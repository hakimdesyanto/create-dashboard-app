---
to: src/services/base/admin/user.ts
---
import { fetchData } from '@/src/packages/utils/fetch-data'
import { faker } from '@faker-js/faker'

const BASE_API = process.env.NEXT_PUBLIC_SERVICE_BASE_API

interface MetadataProps {
  filters?: any
  sort?: any
  pagination: {
    page: number
    page_size: number
    has_next_page: boolean
  }
}

export const getAdminUsers = async (metadata: MetadataProps): Promise<any> => {
  try {
    const response = await fetchData({
      method: 'get',
      baseURL: `${BASE_API}`,
      url: `/admin/user`,
      params: {
        filters: metadata?.filters,
        sort: metadata?.sort,
        pagination: {
          page: metadata?.pagination?.page,
          page_size: metadata?.pagination?.page_size,
        },
      },
      mock: {
        body: {
          data: faker.helpers.multiple(
            (): any => {
              return {
                id: faker.number.int({ min: 1000, max: 9000 }),
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
                is_active: faker.datatype.boolean(),
                image: faker.image.avatar(),
              }
            },
            { count: metadata?.pagination?.page_size },
          ),
          meta: {
            pagination: {
              page: metadata?.pagination?.page,
              page_size: metadata?.pagination?.page_size,
              has_next_page: metadata?.pagination?.page < 10,
            },
          },
        },
      },
    })
    return response
  } catch (error: any) {
    throw new Error(error)
  }
}

export const getAdminUser = async (id: number): Promise<any> => {
  try {
    const response = await fetchData({
      method: 'get',
      baseURL: `${BASE_API}`,
      url: `/admin/user/${id}`,
      mock: {
        body: {
          data: [
            {
              id,
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
              is_active: faker.datatype.boolean(),
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

export const addAdminUser = async (data: any): Promise<any> => {
  try {
    const response = await fetchData({
      method: 'post',
      baseURL: `${BASE_API}`,
      url: `/admin/user`,
      data,
      mock: {
        status: 201,
      },
    })
    return response
  } catch (error: any) {
    throw new Error(error)
  }
}

export const updateAdminUser = async (id: number, data: any): Promise<any> => {
  try {
    const response = await fetchData({
      method: 'post',
      baseURL: `${BASE_API}`,
      url: `/admin/user/${id}`,
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
