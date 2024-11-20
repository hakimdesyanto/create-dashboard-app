---
to: src/app/(dashboard)/(administrators)/admin/role/detail/page.tsx
---
'use client'

import { useLayoutContext } from '@/src/context/LayoutContext'
import { getAdminRole } from '@/src/services/base/admin/role'
import { notFound, useSearchParams } from 'next/navigation'
import { useEffect, useState } from 'react'
import AdminRoleDetail from '.'

export default function AdminRoleDetailPage() {
  const searchParams = useSearchParams()
  const { toast: { setToast } } = useLayoutContext()
  const id = searchParams.get('id')
    ? Number(searchParams.get('id'))
    : undefined
  const [adminRole, setAdminRole] = useState(null)

  if (!id) {
    notFound()
  }

  useEffect(() => {
    const fetchGetAdminRole = async (): Promise<any> => {
      try {
        const response = await getAdminRole(id)
        if (response.status === 200) {
          setAdminRole(response.data.data[0])
        } else {
          setToast({
            message: 'Failed to get Admin Role data',
            show: true,
          })
        }
      } catch (error: any) {
        throw new Error(error)
      }
    }
    fetchGetAdminRole()
  }, [])

  return adminRole && <AdminRoleDetail adminRole={adminRole} />
}
