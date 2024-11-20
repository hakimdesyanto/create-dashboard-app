---
to: src/services/base/account/index.ts
---
import { fetchData } from '@/src/packages/utils/fetch-data'
import { faker } from '@faker-js/faker'

const BASE_API = process.env.NEXT_PUBLIC_SERVICE_BASE_API

export const loginAccount = async (data: any): Promise<any> => {
  try {
    const response = await fetchData({
      method: 'post',
      baseURL: `${BASE_API}`,
      url: '/account/login',
      data,
      mock: {
        body: {
          data: [
            {
              token: '__dummy_token_for_running_template__',
              refresh_token: '__dummy_refresh_token_for_running_template__',
            },
          ],
        },
      },
    })
    return response
  } catch (error: any) {
    throw new Error(error)
  }
}

export const getAccount = async (): Promise<any> => {
  try {
    const response = await fetchData({
      method: 'get',
      baseURL: `${BASE_API}`,
      url: '/account',
      mock: {
        body: {
          data: [
            {
              name: faker.person.fullName(),
              email: faker.internet
                .email({ provider: 'kitabisa.com' })
                .toLowerCase(),
              phone_number: faker.string.numeric(12),
              birthdate: faker.date.birthdate(),
              role: faker.helpers.arrayElement([
                {
                  id: 1,
                  name: 'Superadmin',
                },
                {
                  id: 2,
                  name: 'Crowdfunding Ops',
                },
                {
                  id: 3,
                  name: 'Insurance Ops',
                },
              ]),
              department: faker.helpers.arrayElement([
                {
                  id: 1,
                  name: 'Business',
                },
                {
                  id: 2,
                  name: 'Engineering',
                },
                {
                  id: 3,
                  name: 'Product',
                },
              ]),
              image: faker.image.avatar(),
            },
          ],
        },
      },
    })
    return response
  } catch (error: any) {
    throw new Error(error)
  }
}

export const updateAccount = async (data: any): Promise<any> => {
  try {
    const response = await fetchData({
      method: 'post',
      baseURL: `${BASE_API}`,
      url: '/account',
      data,
      mock: {
        status: 200,
      },
    })
    return response
  } catch (error: any) {
    throw new Error(error)
  }
}

export const changePasswordAccount = async (data: any): Promise<any> => {
  try {
    const response = await fetchData({
      method: 'post',
      baseURL: `${BASE_API}`,
      url: '/account/change-password',
      data,
      mock: {
        status: 200,
      },
    })
    return response
  } catch (error: any) {
    throw new Error(error)
  }
}
