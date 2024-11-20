---
to: src/app/(dashboard)/(administrators)/admin/role/components/TableNavigation.tsx
---
import { Button } from 'flowbite-react'
import type { FC } from 'react'
import { HiChevronLeft, HiChevronRight } from 'react-icons/hi'

const TableNavigation: FC<any> = function ({ metadata, setMetadata }) {
  const {
    pagination: { page, page_size, has_next_page },
  } = metadata
  const navPages = []
  for (let i = page - 1; i < page + 2; i++) {
    let nav = !has_next_page ? i - 1 : i
    if (nav > 0) {
      navPages.push(nav)
    }
  }

  return (
    <div className="sticky bottom-0 right-0 w-full items-center border-t border-gray-200 bg-white p-4 sm:flex sm:justify-between dark:border-gray-700 dark:bg-gray-800">
      <div className="mb-4 flex items-center sm:mb-0">
        <span className="text-sm font-normal text-gray-500 dark:text-gray-400">
          Showing{' '}
          <span className="font-semibold text-gray-900 dark:text-white">
            {(page - 1) * page_size + 1} - {page * page_size}
          </span>
        </span>
      </div>
      <div className="flex items-center space-x-3">
        <Button
          color="light"
          size="sm"
          disabled={page === 1}
          onClick={() => {
            setMetadata((prevState: any) => ({
              ...prevState,
              pagination: {
                ...prevState.pagination,
                page: page - 1,
              },
            }))
          }}
        >
          <HiChevronLeft className="-ml-1 mr-1 h-5 w-5" />
          <span className="hidden sm:block">Previous</span>
        </Button>
        {navPages.map((navPage) => (
          <Button
            key={navPage}
            color={navPage === page ? 'primary' : 'light'}
            size="sm"
            className="min-w-12"
            onClick={() => {
              setMetadata((prevState: any) => ({
                ...prevState,
                pagination: {
                  ...prevState.pagination,
                  page: navPage,
                },
              }))
            }}
          >
            {navPage}
          </Button>
        ))}
        <Button
          color="light"
          size="sm"
          disabled={!has_next_page}
          onClick={() => {
            setMetadata((prevState: any) => ({
              ...prevState,
              pagination: {
                ...prevState.pagination,
                page: page + 1,
              },
            }))
          }}
        >
          <span className="hidden sm:block">Next</span>
          <HiChevronRight className="-mr-1 ml-1 h-5 w-5" />
        </Button>
      </div>
    </div>
  )
}

export default TableNavigation
