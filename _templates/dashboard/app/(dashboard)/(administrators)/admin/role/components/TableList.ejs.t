---
to: src/app/(dashboard)/(administrators)/admin/role/components/TableList.tsx
---
import { Button, Table } from 'flowbite-react'
import type { FC } from 'react'
import { HiCheck, HiPencilAlt, HiUsers, HiX } from 'react-icons/hi'

const TableList: FC<any> = function ({ adminRoles }) {
  return (
    <Table
      className="min-w-full divide-y divide-gray-200 dark:divide-gray-600"
      theme={{
        head: {
          base: 'bg-gray-100 dark:bg-gray-700',
          cell: {
            base: 'p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400',
          },
        },
        body: {
          cell: {
            base: 'rounded-none',
          },
        },
      }}
    >
      <Table.Head className="sticky top-0 z-10 bg-gray-100 dark:bg-gray-700">
        <Table.HeadCell className="whitespace-nowrap">ID</Table.HeadCell>
        <Table.HeadCell className="whitespace-nowrap text-left">
          Role Name
        </Table.HeadCell>
        <Table.HeadCell className="whitespace-nowrap text-center">
          Users
        </Table.HeadCell>
        <Table.HeadCell className="whitespace-nowrap text-center">
          Is Active
        </Table.HeadCell>
        <Table.HeadCell className="sticky right-0 whitespace-nowrap bg-gray-100 text-center dark:bg-gray-700">
          Actions
        </Table.HeadCell>
      </Table.Head>
      <Table.Body className="divide-y divide-gray-200 bg-white dark:divide-gray-700 dark:bg-gray-800">
        {adminRoles.map(
          ({
            id,
            name,
            users,
            is_active,
          }: any, i: number) => (
            <Table.Row
              key={i}
              className="hover:bg-gray-100 dark:hover:bg-gray-700"
            >
              <Table.Cell className="whitespace-nowrap p-4 text-base font-medium text-gray-900 dark:text-white">
                {id}
              </Table.Cell>
              <Table.Cell
                align="left"
                className="whitespace-nowrap p-4 text-base font-medium text-gray-900 dark:text-white"
              >
                {name}
              </Table.Cell>
              <Table.Cell
                align="center"
                className="whitespace-nowrap p-4 text-base font-medium text-gray-900 dark:text-white"
              >
                <div className="flex gap-2 items-center justify-center">
                  <HiUsers />
                  {users}
                </div>
              </Table.Cell>
              <Table.Cell
                align="center"
                className="whitespace-nowrap p-4 text-base font-medium text-gray-900 dark:text-white"
              >
                {is_active ? (
                  <HiCheck className="font-bold text-green-500" />
                ) : (
                  <HiX className="text-red-500" />
                )}
              </Table.Cell>
              <Table.Cell className="sticky right-0 space-x-2 whitespace-nowrap bg-white p-4 group-hover/row:bg-gray-100 dark:bg-gray-800 dark:group-hover/row:bg-gray-700">
                <div className="flex items-center justify-center gap-x-3">
                  <Button
                    size="sm"
                    color="primary"
                    href={`/admin/role/detail?id=${id}`}
                  >
                    <HiPencilAlt className="mr-2 h-5 w-5" />
                    Edit
                  </Button>
                </div>
              </Table.Cell>
            </Table.Row>
          ),
        )}
      </Table.Body>
    </Table>
  )
}

export default TableList
