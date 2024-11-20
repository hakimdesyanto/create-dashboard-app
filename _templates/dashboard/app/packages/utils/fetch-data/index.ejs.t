---
to: src/packages/utils/fetch-data/index.ts
---

import axios, { AxiosError, AxiosRequestConfig } from 'axios'
import Router from 'next/router'
import Cookies from 'universal-cookie'

interface CustomAxiosRequestConfig {
  mock?: {
    body?: Record<string, any>
    status?: number
    headers?: Record<string, any>
    delay?: number
    schema?: Record<string, any>
  }
  refreshTokenUrl?: string
  refreshTokenPayloadKey?: string
}

interface FetchDataRequestConfig
  extends AxiosRequestConfig,
    CustomAxiosRequestConfig {}

interface RefreshTokenResponse {
  access_token: string
  refreshToken: string
}

const httpClient = axios.create()
const cookies = new Cookies()
let _customHeaders = {
  'X-Ktbs-Api-Version': '',
  'X-Ktbs-Client-Version': '',
  'X-Ktbs-Platform-Name': '',
  'X-Ktbs-Client-Name': '',
  'X-Ktbs-Request-ID': '',
  'X-Ktbs-Signature': '',
  'X-Ktbs-Time': '',
}
let _refreshTokenUrl = ''
let _refreshTokenPayloadKey = 'refreshToken'

export const fetchData = async (
  fetchConfig: FetchDataRequestConfig,
): Promise<any> => {
  try {
    const config = getAxiosConfig(fetchConfig)
    const response = await httpClient(config)
    return response
  } catch (error: any) {
    if (+(error?.response?.status ?? 0) === 401) {
      cookies.remove('user_token', {
        path: '/',
      })
      cookies.remove('refresh_token', {
        path: '/',
      })
      Router.push('/auth/sign-in')
    } else {
      throw error
    }
  }
}

const getAxiosConfig = (
  fetchConfig: FetchDataRequestConfig,
): AxiosRequestConfig => {
  const { mock, refreshTokenUrl, refreshTokenPayloadKey, ...config } =
    fetchConfig
  const userToken = cookies.get('user_token') || ''
  if (!config.timeout) {
    config.timeout = 15000
  }
  config.headers = {
    Accept: 'application/json',
    'Content-Type': 'application/json',
    ...(userToken && {
      Authorization: `Bearer ${userToken}`,
    }),
    ...config.headers,
  }
  if (config.headers) {
    _customHeaders['X-Ktbs-Api-Version'] = config.headers['X-Ktbs-Api-Version']
    _customHeaders['X-Ktbs-Client-Version'] =
      config.headers['X-Ktbs-Client-Version']
    _customHeaders['X-Ktbs-Platform-Name'] =
      config.headers['X-Ktbs-Platform-Name']
    _customHeaders['X-Ktbs-Client-Name'] = config.headers['X-Ktbs-Client-Name']
    _customHeaders['X-Ktbs-Request-ID'] = config.headers['X-Ktbs-Request-ID']
    _customHeaders['X-Ktbs-Signature'] = config.headers['X-Ktbs-Signature']
    _customHeaders['X-Ktbs-Time'] = config.headers['X-Ktbs-Time']
  }
  if (refreshTokenUrl) _refreshTokenUrl = refreshTokenUrl
  if (refreshTokenPayloadKey) _refreshTokenPayloadKey = 'refresh_token'
  if (mock) {
    config.baseURL = `${process.env.NEXT_PUBLIC_SERVICE_SMOCKR_API}`
    config.headers = {
      ...config.headers,
      'X-Smockr-Secret': `${process.env.NEXT_PUBLIC_SERVICE_SMOCKR_SECRET_KEY}`,
    }
    config.params = {
      ...config.params,
      mock: {
        response: {
          body: mock.body ? JSON.stringify(mock.body) : undefined,
          headers: mock.headers ? JSON.stringify(mock.headers) : undefined,
          status: mock.status,
          delay: mock.delay,
        },
        ...(mock.schema && {
          request: {
            body: {
              schema: JSON.stringify(mock.schema),
            },
          },
        }),
      },
    }
  }
  return config
}

const refreshAccessToken = async (refreshToken: string): Promise<string> => {
  try {
    const response = await httpClient.post<RefreshTokenResponse>(
      _refreshTokenUrl ||
        process.env.NEXT_PUBLIC_REFRESH_TOKEN_API ||
        '/refresh-token-endpoint',
      {
        [_refreshTokenPayloadKey]: refreshToken,
      },
      {
        headers: {
          ..._customHeaders,
        },
      },
    )

    const newAccessToken = (response.data as any).data[0].access_token
    httpClient.defaults.headers.common['Authorization'] =
      `Bearer ${newAccessToken}`
    cookies.set('user_token', newAccessToken, {
      path: '/',
      expires: new Date(new Date().setHours(new Date().getHours() + 2)),
    })

    return newAccessToken
  } catch (error) {
    throw error
  }
}

httpClient.interceptors.response.use(
  (response) => response,
  async (error: AxiosError) => {
    const originalRequest = error.config as AxiosRequestConfig

    if (error.response?.status === 401) {
      if (error.response.config.url === _refreshTokenUrl) throw error
      try {
        const refreshToken = cookies.get('refresh_token') || ''
        const newAccessToken = await refreshAccessToken(refreshToken)
        originalRequest.headers = {
          ...originalRequest.headers,
          Authorization: `Bearer ${newAccessToken}`,
        }
        return axios(originalRequest)
      } catch (_) {
        return axios(originalRequest)
      }
    }
    return Promise.reject(error)
  },
)
