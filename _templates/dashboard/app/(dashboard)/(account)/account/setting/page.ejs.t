---
to: src/app/(dashboard)/(account)/account/setting/page.tsx
---
'use client'

import { useLayoutContext } from '@/src/context/LayoutContext'
import { getAccount } from '@/src/services/base/account'
import { useEffect, useState } from 'react'
import AccountSetting from '.'

export default function AccountSettingPage() {
  const { toast: { setToast } } = useLayoutContext()
  const [userProfile, setUserProfile] = useState(null)

  useEffect(() => {
    const fetchGetAccount = async (): Promise<any> => {
      try {
        const response = await getAccount()
        if (response.status === 200) {
          setUserProfile(response.data.data[0])
        } else {
          setToast({
            message: 'Failed to get Account data',
            show: true,
          })
        }
      } catch (error: any) {
        throw new Error(error)
      }
    }
    fetchGetAccount()
  }, [])

  return userProfile && <AccountSetting userProfile={userProfile} />
}
