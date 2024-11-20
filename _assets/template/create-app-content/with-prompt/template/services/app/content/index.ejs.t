---
to: src/services/<%=serviceName%>/<%=contentName%>/index.ts
---
import { fetchData } from '@/src/packages/utils/fetch-data'
import { faker } from '@faker-js/faker'

const <%=h.changeCase.upperCase(serviceName)%>_API = process.env.NEXT_PUBLIC_SERVICE_<%=h.changeCase.upperCase(serviceName)%>_API

interface MetadataProps {
  filters?: any
  sort?: any
  pagination: {
    page: number
    page_size: number
    has_next_page: boolean
  }
}

export const get<%=h.changeCase.pascalCase(h.inflection.pluralize(contentName))%> = async (metadata: MetadataProps): Promise<any> => {
  try {
    const response = await fetchData({
      method: 'get',
      baseURL: `${<%=h.changeCase.upperCase(serviceName)%>_API}`,
      url: `/<%=contentName%>`,
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
<% if (isUsingDraftMode) { -%>
                is_draft: faker.datatype.boolean(),
<% } -%>
<% contentFields.forEach((field) => { -%>
<% switch (field.type) {
case 'text': -%>
                <%=field.name%>: faker.commerce.productName(),
<% break;
case 'longtext': -%>
                <%=field.name%>: faker.commerce.productDescription(),
<% break;
case 'richtext': -%>
                <%=field.name%>: faker.commerce.productDescription(),
<% break;
case 'number': -%>
                <%=field.name%>: faker.commerce.price({ dec: 0, min: 1, max: 1000000 }),
<% break;
case 'enum': -%>
                <%=field.name%>: faker.helpers.arrayElement([
                  'Option 1',
                  'Option 2',
                  'Option 3',
                ]),
<% break;
case 'date': -%>
                <%=field.name%>: faker.date.birthdate(),
<% break;
case 'boolean': -%>
                <%=field.name%>: faker.datatype.boolean(),
<% break;
case 'select': -%>
                <%=field.name%>: faker.helpers.arrayElement([
                  {
                    id: 1,
                    name: 'Option 1',
                  },
                  {
                    id: 2,
                    name: 'Option 2',
                  },
                  {
                    id: 3,
                    name: 'Option 3',
                  },
                ]),
<% break;
case 'image': -%>
                <%=field.name%>: faker.image.url(),
<% break;
case 'json': -%>
                <%=field.name%>: faker.datatype.json(),
<% break;
default:
break; } -%>
<% }) -%>
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

export const get<%=h.changeCase.pascalCase(contentName)%> = async (id: number): Promise<any> => {
  try {
    const response = await fetchData({
      method: 'get',
      baseURL: `${<%=h.changeCase.upperCase(serviceName)%>_API}`,
      url: `/<%=contentName%>/${id}`,
      mock: {
        body: {
          data: [
            {
              id,
<% if (isUsingDraftMode) { -%>
              is_draft: faker.datatype.boolean(),
<% } -%>
<% contentFields.forEach((field) => { -%>
<% switch (field.type) {
case 'text': -%>
              <%=field.name%>: faker.commerce.productName(),
<% break;
case 'longtext': -%>
              <%=field.name%>: faker.commerce.productDescription(),
<% break;
case 'richtext': -%>
              <%=field.name%>: faker.commerce.productDescription(),
<% break;
case 'number': -%>
              <%=field.name%>: faker.commerce.price({ dec: 0, min: 1, max: 1000000 }),
<% break;
case 'enum': -%>
              <%=field.name%>: faker.helpers.arrayElement([
                'Option 1',
                'Option 2',
                'Option 3',
              ]),
<% break;
case 'date': -%>
              <%=field.name%>: faker.date.birthdate(),
<% break;
case 'boolean': -%>
              <%=field.name%>: faker.datatype.boolean(),
<% break;
case 'select': -%>
              <%=field.name%>: faker.helpers.arrayElement([
                {
                  id: 1,
                  name: 'Option 1',
                },
                {
                  id: 2,
                  name: 'Option 2',
                },
                {
                  id: 3,
                  name: 'Option 3',
                },
              ]),
<% break;
case 'image': -%>
              <%=field.name%>: faker.image.url(),
<% break;
case 'json': -%>
              <%=field.name%>: faker.datatype.json(),
<% break;
default:
break; } -%>
<% }) -%>
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

export const add<%=h.changeCase.pascalCase(contentName)%> = async (data: any): Promise<any> => {
  try {
    const response = await fetchData({
      method: 'post',
      baseURL: `${<%=h.changeCase.upperCase(serviceName)%>_API}`,
      url: `/<%=contentName%>`,
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

export const update<%=h.changeCase.pascalCase(contentName)%> = async (id: number, data: any): Promise<any> => {
  try {
    const response = await fetchData({
      method: 'post',
      baseURL: `${<%=h.changeCase.upperCase(serviceName)%>_API}`,
      url: `/<%=contentName%>/${id}`,
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

<% if (isUsingDraftMode) { -%>
export const addDraft<%=h.changeCase.pascalCase(contentName)%> = async (data: any): Promise<any> => {
  try {
    const response = await fetchData({
      method: 'post',
      baseURL: `${<%=h.changeCase.upperCase(serviceName)%>_API}`,
      url: `/<%=contentName%>/draft`,
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

export const updateDraft<%=h.changeCase.pascalCase(contentName)%> = async (id: number, data: any): Promise<any> => {
  try {
    const response = await fetchData({
      method: 'post',
      baseURL: `${<%=h.changeCase.upperCase(serviceName)%>_API}`,
      url: `/<%=contentName%>/draft/${id}`,
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

<% } -%>