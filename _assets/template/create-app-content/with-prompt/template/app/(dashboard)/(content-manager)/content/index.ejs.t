---
to: src/app/(dashboard)/(content-manager)/<%=contentName%>/index.tsx
---
'use client'

import { Breadcrumb, Button } from 'flowbite-react'
import type { FC } from 'react'
import { FaPlus } from 'react-icons/fa'
import { HiHome } from 'react-icons/hi'
import SearchFilter from './components/SearchFilter'
import TableList from './components/TableList'
import TableNavigation from './components/TableNavigation'

const <%=h.changeCase.pascalCase(h.inflection.pluralize(contentName))%>: FC<any> = function ({ <%=h.changeCase.camelCase(h.inflection.pluralize(contentName))%>, metadata, setMetadata }) {
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
              <Breadcrumb.Item><%=h.changeCase.titleCase(h.inflection.pluralize(contentName))%></Breadcrumb.Item>
            </Breadcrumb>
          </div>
          <div className="flex flex-wrap justify-between items-center gap-4">
            <h1 className="whitespace-nowrap text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">
              All <%=h.changeCase.titleCase(contentName)%>
            </h1>
            <div className="flex gap-4 items-center sm:justify-end">
              <SearchFilter
                metadata={metadata}
                setMetadata={setMetadata}
              />
              <Button color="primary" href="/<%=contentName%>/add">
                <FaPlus className="mr-3 text-sm" />
                Add
              </Button>
            </div>
          </div>
        </div>
      </div>
      <div className="flex flex-col">
        <div>
          <div className="overflow-x-auto min-w-full align-middle">
            <div className="overflow-y-auto shadow max-h-[calc(100vh-290px)] xs:max-h-[calc(100vh-334px)] sm:max-h-[calc(100vh-254px)] md:max-h-[calc(100vh-254px)] lg:max-h-[calc(100vh-254px)]">
              <TableList <%=h.changeCase.camelCase(h.inflection.pluralize(contentName))%>={<%=h.changeCase.camelCase(h.inflection.pluralize(contentName))%>} />
            </div>
          </div>
        </div>
      </div>
      <TableNavigation
        metadata={metadata}
        setMetadata={setMetadata}
      />
    </>
  )
}

export default <%=h.changeCase.pascalCase(h.inflection.pluralize(contentName))%>
