---
to: src/app/(dashboard)/(account)/account/setting/index.tsx
---
'use client'

import { Breadcrumb } from 'flowbite-react'
import type { FC } from 'react'
import { HiHome } from 'react-icons/hi'
import ChangePassword from './components/ChangePassword'
import UserProfile from './components/UserProfile'

const AccountSetting: FC<any> = function ({ userProfile }) {
  return (
    <>
      <div className="grid grid-cols-1 p-4 xl:grid-cols-3 xl:gap-4 dark:bg-gray-900">
        <div className="col-span-full mb-4 xl:mb-2">
          <Breadcrumb className="mb-5">
            <Breadcrumb.Item href="/">
              <div className="flex items-center gap-x-3">
                <HiHome className="text-xl" />
                <span className="dark:text-white">Home</span>
              </div>
            </Breadcrumb.Item>
            <Breadcrumb.Item>Account</Breadcrumb.Item>
            <Breadcrumb.Item>Setting</Breadcrumb.Item>
          </Breadcrumb>
          <h1 className="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">
            Account settings
          </h1>
        </div>
        <div className="col-span-2">
          <UserProfile userProfile={userProfile} />
        </div>
        <div className="col-span-full mb-4 xl:col-auto xl:mb-0">
          <div className="grid grid-cols-1 gap-y-4">
            <ChangePassword />
          </div>
        </div>
      </div>
    </>
  )
}

export default AccountSetting
