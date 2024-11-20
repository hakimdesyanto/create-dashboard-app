---
to: src/services/base/admin/role.ts
---
import { fetchData } from '@/src/packages/utils/fetch-data'
import { faker } from '@faker-js/faker'
import contentMenus from '../../../app/(dashboard)/content-menus.json'

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

export const getAdminRoles = async (metadata: MetadataProps): Promise<any> => {
  try {
    const response = await fetchData({
      method: 'get',
      baseURL: `${BASE_API}`,
      url: `/admin/role`,
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
                id: faker.number.int({ min: 1, max: 10 }),
                name: faker.helpers.arrayElement([
                  'Superadmin',
                  'Crowdfunding Ops',
                  'Insurance Ops',
                ]),
                users: faker.number.int({ min: 1, max: 30 }),
                is_active: faker.datatype.boolean(),
              }
            },
            { count: 3 },
          ),
          meta: {
            pagination: {
              page: metadata?.pagination?.page,
              page_size: metadata?.pagination?.page_size,
              has_next_page: metadata?.pagination?.page < 1,
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

export const getAdminRole = async (id: number): Promise<any> => {
  try {
    const response = await fetchData({
      method: 'get',
      baseURL: `${BASE_API}`,
      url: `/admin/role/${id}`,
      mock: {
        body: {
          data: [
            {
              id,
              name: faker.helpers.arrayElement([
                'Superadmin',
                'Crowdfunding Ops',
                'Insurance Ops',
              ]),
              permissions: faker.helpers.arrayElements(
                Array.from(Array(15 + 1).keys()).slice(1),
                { min: 5, max: 10 },
              ),
              is_active: faker.datatype.boolean(),
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

export const getAdminRolePermissions = async (): Promise<any> => {
  try {
    const response = await fetchData({
      method: 'get',
      baseURL: `${BASE_API}`,
      url: `/admin/role/permission`,
      mock: {
        body: {
          data: [
            ...(() => {
              let content: any = [
                {
                  id: 1,
                  slug: 'admin/user',
                  name: 'Admin Users',
                  actions: [
                    {
                      id: 1,
                      slug: 'create',
                      name: 'Create',
                    },
                    {
                      id: 2,
                      slug: 'read',
                      name: 'Read',
                    },
                    {
                      id: 3,
                      slug: 'update',
                      name: 'Update',
                    },
                  ],
                },
                {
                  id: 2,
                  slug: 'admin/role',
                  name: 'Admin Roles',
                  actions: [
                    {
                      id: 4,
                      slug: 'create',
                      name: 'Create',
                    },
                    {
                      id: 5,
                      slug: 'read',
                      name: 'Read',
                    },
                    {
                      id: 6,
                      slug: 'update',
                      name: 'Update',
                    },
                  ],
                },
              ]
              contentMenus.map((menu: any) => {
                if (menu.submenus) {
                  menu.submenus.map((submenu: any) => {
                    const id = content.length + 1
                    content.push({
                      id: id,
                      slug: submenu.name,
                      name: submenu.label,
                      actions: [
                        {
                          id: id * 3 - 2,
                          slug: 'create',
                          name: 'Create',
                        },
                        {
                          id: id * 3 - 1,
                          slug: 'read',
                          name: 'Read',
                        },
                        {
                          id: id * 3,
                          slug: 'update',
                          name: 'Update',
                        },
                      ],
                    })
                  })
                } else {
                  const id = content.length + 1
                  content.push({
                    id: id,
                    slug: menu.name,
                    name: menu.label,
                    actions: [
                      {
                        id: id * 3 - 2,
                        slug: 'create',
                        name: 'Create',
                      },
                      {
                        id: id * 3 - 1,
                        slug: 'read',
                        name: 'Read',
                      },
                      {
                        id: id * 3,
                        slug: 'update',
                        name: 'Update',
                      },
                    ],
                  })
                }
              })
              return content
            })(),
          ],
        },
      },
    })
    return response
  } catch (error: any) {
    throw new Error(error)
  }
}

export const addAdminRole = async (data: any): Promise<any> => {
  try {
    const response = await fetchData({
      method: 'post',
      baseURL: `${BASE_API}`,
      url: `/admin/role`,
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

export const updateAdminRole = async (id: number, data: any): Promise<any> => {
  try {
    const response = await fetchData({
      method: 'post',
      baseURL: `${BASE_API}`,
      url: `/admin/role/${id}`,
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
