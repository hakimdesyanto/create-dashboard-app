---
to: src/app/(dashboard)/(content-manager)/<%=contentName%>/detail/page.tsx
---
'use client'

import { useLayoutContext } from '@/src/context/LayoutContext'
import { get<%=h.changeCase.pascalCase(contentName)%> } from '@/src/services/<%=serviceName%>/<%=contentName%>'
import { notFound, useSearchParams } from 'next/navigation'
import { useState, useEffect } from 'react'
import <%=h.changeCase.pascalCase(contentName)%>Detail from '.'

export default function <%=h.changeCase.pascalCase(contentName)%>DetailPage() {
  const searchParams = useSearchParams()
  const { toast: { setToast } } = useLayoutContext()
  const id = searchParams.get('id')
    ? Number(searchParams.get('id'))
    : undefined
  const [<%=h.changeCase.camelCase(contentName)%>, set<%=h.changeCase.pascalCase(contentName)%>] = useState(null)

  if (!id) {
    notFound()
  }

  useEffect(() => {
    const fetchGet<%=h.changeCase.pascalCase(contentName)%> = async (): Promise<any> => {
      try {
        const response = await get<%=h.changeCase.pascalCase(contentName)%>(id)
        if (response.status === 200) {
          set<%=h.changeCase.pascalCase(contentName)%>(response.data.data[0])
        } else {
          setToast({
            message: 'Failed to get <%=h.changeCase.titleCase(contentName)%> data',
            show: true,
          })
        }
      } catch (error: any) {
        throw new Error(error)
      }
    }
    fetchGet<%=h.changeCase.pascalCase(contentName)%>()
  }, [])

  return <%=h.changeCase.camelCase(contentName)%> && <<%=h.changeCase.pascalCase(contentName)%>Detail <%=h.changeCase.camelCase(contentName)%>={<%=h.changeCase.camelCase(contentName)%>} />
}
