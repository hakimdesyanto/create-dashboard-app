---
to: src/app/(dashboard)/(administrators)/admin/user/add/index.tsx
---
'use client'

import { Breadcrumb } from 'flowbite-react'
import type { FC } from 'react'
import { HiHome } from 'react-icons/hi'
import ContentForm from '../components/ContentForm'

const AdminUserAdd: FC = function () {
  return (
    <>
      <div className="mb-4 grid grid-cols-1 gap-y-6 p-4 xl:gap-4 dark:border-gray-700 dark:bg-gray-900">
        <div className="col-span-full xl:mb-2">
          <Breadcrumb className="mb-5">
            <Breadcrumb.Item href="/">
              <div className="flex items-center gap-x-3">
                <HiHome className="text-xl" />
                <span className="dark:text-white">Home</span>
              </div>
            </Breadcrumb.Item>
            <Breadcrumb.Item>Administrators</Breadcrumb.Item>
            <Breadcrumb.Item href="/admin/user">Users</Breadcrumb.Item>
            <Breadcrumb.Item>Add</Breadcrumb.Item>
          </Breadcrumb>
          <h1 className="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">
            Add Admin User
          </h1>
        </div>
        <div className="grid grid-cols-1 gap-y-4 px-4">
          <ContentForm />
        </div>
      </div>
    </>
  )
}

export default AdminUserAdd
