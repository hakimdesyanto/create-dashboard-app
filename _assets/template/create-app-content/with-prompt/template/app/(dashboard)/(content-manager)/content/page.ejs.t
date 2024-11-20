---
to: src/app/(dashboard)/(content-manager)/<%=contentName%>/page.tsx
---
'use client'

import { useLayoutContext } from '@/src/context/LayoutContext'
import { get<%=h.changeCase.pascalCase(h.inflection.pluralize(contentName))%> } from '@/src/services/<%=serviceName%>/<%=contentName%>'
import { useEffect, useState } from 'react'
import <%=h.changeCase.pascalCase(h.inflection.pluralize(contentName))%> from '.'

export default function <%=h.changeCase.pascalCase(h.inflection.pluralize(contentName))%>Page() {
  const { toast: { setToast } } = useLayoutContext()
  const [<%=h.changeCase.camelCase(h.inflection.pluralize(contentName))%>, set<%=h.changeCase.pascalCase(h.inflection.pluralize(contentName))%>] = useState(null)
  const [metadata, setMetadata] = useState({
    filters: null,
    sort: null,
    pagination: {
      page: 1,
      page_size: 10,
      has_next_page: false,
    },
  })

  useEffect(() => {
    const fetchGet<%=h.changeCase.pascalCase(h.inflection.pluralize(contentName))%> = async (): Promise<any> => {
      try {
        const response = await get<%=h.changeCase.pascalCase(h.inflection.pluralize(contentName))%>(metadata)
        if (response.status === 200) {
          set<%=h.changeCase.pascalCase(h.inflection.pluralize(contentName))%>(response.data.data)
          setMetadata((prevState: any) => ({
            ...prevState,
            pagination: {
              ...prevState.pagination,
              has_next_page: response.data?.meta?.pagination?.has_next_page
            },
          }))
        } else {
          setToast({
            message: 'Failed to get <%=h.changeCase.titleCase(h.inflection.pluralize(contentName))%> data',
            show: true,
          })
        }
      } catch (error: any) {
        throw new Error(error)
      }
    }
    fetchGet<%=h.changeCase.pascalCase(h.inflection.pluralize(contentName))%>()
  }, [metadata.filters, metadata.sort, metadata.pagination.page])

  return <%=h.changeCase.camelCase(h.inflection.pluralize(contentName))%> && (
    <<%=h.changeCase.pascalCase(h.inflection.pluralize(contentName))%>
      <%=h.changeCase.camelCase(h.inflection.pluralize(contentName))%>={<%=h.changeCase.camelCase(h.inflection.pluralize(contentName))%>}
      metadata={metadata}
      setMetadata={setMetadata}
    />
  )
}
