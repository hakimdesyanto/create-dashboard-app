---
to: src/services/gudang/image/index.ts
---
import { fetchData } from '@/src/packages/utils/fetch-data'

const GUDANG_API = process.env.NEXT_PUBLIC_SERVICE_GUDANG_API
const GUDANG_USERNAME = process.env.NEXT_PUBLIC_SERVICE_GUDANG_USERNAME
const GUDANG_PASSWORD = process.env.NEXT_PUBLIC_SERVICE_GUDANG_PASSWORD
const GUDANG_IMGIX_URL = process.env.NEXT_PUBLIC_SERVICE_GUDANG_IMGIX_URL

export const getImageUrl = (url: string): string => {
  return `${GUDANG_IMGIX_URL}/${url}?auto=format&fm=pjpg&cs=tinysrgb`
}

export const setFormDataImage = (file: any, durability?: 'temporary' | 'permanent'): any => {
  const data = new FormData()
  data.append('file', file)
  data.append('durability', durability || 'temporary')
  return data
}

export const uploadImage = async (data: any): Promise<any> => {
  try {
    const response = await fetchData({
      method: 'post',
      baseURL: `${GUDANG_API}`,
      url: '/upload',
      headers: {
        'Content-Type': 'multipart/form-data',
      },
      auth: {
        username: `${GUDANG_USERNAME}`,
        password: `${GUDANG_PASSWORD}`,
      },
      data,
    })
    return response
  } catch (error: any) {
    throw new Error(error)
  }
}
