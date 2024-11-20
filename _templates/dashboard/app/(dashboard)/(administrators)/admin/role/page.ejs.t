---
to: src/app/(dashboard)/(administrators)/admin/role/page.tsx
---
'use client'

import { useLayoutContext } from '@/src/context/LayoutContext'
import { getAdminRoles } from '@/src/services/base/admin/role'
import { useEffect, useState } from 'react'
import AdminRoles from '.'

export default function AdminRolesPage() {
  const { toast: { setToast } } = useLayoutContext()
  const [adminRoles, setAdminRoles] = useState(null)
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
    const fetchGetAdminRoles = async (): Promise<any> => {
      try {
        const response = await getAdminRoles(metadata)
        if (response.status === 200) {
          setAdminRoles(response.data.data)
          setMetadata((prevState: any) => ({
            ...prevState,
            pagination: {
              ...prevState.pagination,
              has_next_page: response.data?.meta?.pagination?.has_next_page,
            },
          }))
        } else {
          setToast({
            message: 'Failed to get Admin Roles data',
            show: true,
          })
        }
      } catch (error: any) {
        throw new Error(error)
      }
    }
    fetchGetAdminRoles()
  }, [metadata.filters, metadata.sort, metadata.pagination.page])

  return (
    adminRoles && (
      <AdminRoles
        adminRoles={adminRoles}
        metadata={metadata}
        setMetadata={setMetadata}
      />
    )
  )
}
