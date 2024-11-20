---
to: src/app/(dashboard)/(administrators)/admin/role/index.tsx
---
'use client'

import { Breadcrumb, Button } from 'flowbite-react'
import type { FC } from 'react'
import { FaPlus } from 'react-icons/fa'
import { HiHome } from 'react-icons/hi'
import SearchFilter from './components/SearchFilter'
import TableList from './components/TableList'
import TableNavigation from './components/TableNavigation'

const AdminRoles: FC<any> = function ({ adminRoles, metadata, setMetadata }) {
  return (
    <>
      <div className="block items-center justify-between border-b border-gray-200 bg-white p-4 sm:flex dark:border-gray-700 dark:bg-gray-800">
        <div className="mb-1 w-full">
          <div className="mb-4">
            <Breadcrumb className="mb-5">
              <Breadcrumb.Item href="/">
                <div className="flex items-center gap-x-3">
                  <HiHome className="text-xl" />
                  <span className="dark:text-white">Home</span>
                </div>
              </Breadcrumb.Item>
              <Breadcrumb.Item>Administrators</Breadcrumb.Item>
              <Breadcrumb.Item>Roles</Breadcrumb.Item>
            </Breadcrumb>
          </div>
          <div className="flex flex-wrap items-center justify-between gap-4">
            <h1 className="whitespace-nowrap text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">
              All Admin Role
            </h1>
            <div className="flex items-center gap-4 sm:justify-end">
              <SearchFilter metadata={metadata} setMetadata={setMetadata} />
              <Button color="primary" href="/admin/role/add">
                <FaPlus className="mr-3 text-sm" />
                Add
              </Button>
            </div>
          </div>
        </div>
      </div>
      <div className="flex flex-col">
        <div>
          <div className="min-w-full overflow-x-auto align-middle">
            <div className="xs:max-h-[calc(100vh-334px)] max-h-[calc(100vh-290px)] overflow-y-auto shadow sm:max-h-[calc(100vh-254px)] md:max-h-[calc(100vh-254px)] lg:max-h-[calc(100vh-254px)]">
              <TableList adminRoles={adminRoles} />
            </div>
          </div>
        </div>
      </div>
      <TableNavigation metadata={metadata} setMetadata={setMetadata} />
    </>
  )
}

export default AdminRoles
