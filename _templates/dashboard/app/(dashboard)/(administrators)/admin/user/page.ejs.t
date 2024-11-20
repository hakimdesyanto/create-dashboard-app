---
to: src/app/(dashboard)/(administrators)/admin/user/page.tsx
---
'use client'

import { useLayoutContext } from '@/src/context/LayoutContext'
import { getAdminUsers } from '@/src/services/base/admin/user'
import { useEffect, useState } from 'react'
import AdminUsers from '.'

export default function AdminUsersPage() {
  const { toast: { setToast } } = useLayoutContext()
  const [adminUsers, setAdminUsers] = useState(null)
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
    const fetchGetAdminUsers = async (): Promise<any> => {
      try {
        const response = await getAdminUsers(metadata)
        if (response.status === 200) {
          setAdminUsers(response.data.data)
          setMetadata((prevState: any) => ({
            ...prevState,
            pagination: {
              ...prevState.pagination,
              has_next_page: response.data?.meta?.pagination?.has_next_page,
            },
          }))
        } else {
          setToast({
            message: 'Failed to get Admin Users data',
            show: true,
          })
        }
      } catch (error: any) {
        throw new Error(error)
      }
    }
    fetchGetAdminUsers()
  }, [metadata.filters, metadata.sort, metadata.pagination.page])

  return (
    adminUsers && (
      <AdminUsers
        adminUsers={adminUsers}
        metadata={metadata}
        setMetadata={setMetadata}
      />
    )
  )
}
