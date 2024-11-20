---
to: src/app/(dashboard)/(administrators)/admin/user/detail/page.tsx
---
'use client'

import { useLayoutContext } from '@/src/context/LayoutContext'
import { getAdminUser } from '@/src/services/base/admin/user'
import { notFound, useSearchParams } from 'next/navigation'
import { useEffect, useState } from 'react'
import AdminUserDetail from '.'

export default function AdminUserDetailPage() {
  const searchParams = useSearchParams()
  const { toast: { setToast } } = useLayoutContext()
  const id = searchParams.get('id')
    ? Number(searchParams.get('id'))
    : undefined
  const [adminUser, setAdminUser] = useState(null)

  if (!id) {
    notFound()
  }

  useEffect(() => {
    const fetchGetAdminUser = async (): Promise<any> => {
      try {
        const response = await getAdminUser(id)
        if (response.status === 200) {
          setAdminUser(response.data.data[0])
        } else {
          setToast({
            message: 'Failed to get Admin User data',
            show: true,
          })
        }
      } catch (error: any) {
        throw new Error(error)
      }
    }
    fetchGetAdminUser()
  }, [])

  return adminUser && <AdminUserDetail adminUser={adminUser} />
}
