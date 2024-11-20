---
to: src/app/(dashboard)/(administrators)/admin/user/components/TableList.tsx
---
import { Badge, Button, Table } from 'flowbite-react'
import Image from 'next/image'
import type { FC } from 'react'
import { HiCheck, HiPencilAlt, HiX } from 'react-icons/hi'

const TableList: FC<any> = function ({ adminUsers }) {
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
          Name
        </Table.HeadCell>
        <Table.HeadCell className="whitespace-nowrap text-center">
          Email
        </Table.HeadCell>
        <Table.HeadCell className="whitespace-nowrap text-center">
          Phone Number
        </Table.HeadCell>
        <Table.HeadCell className="whitespace-nowrap text-center">
          Birthdate
        </Table.HeadCell>
        <Table.HeadCell className="whitespace-nowrap text-center">
          Role
        </Table.HeadCell>
        <Table.HeadCell className="whitespace-nowrap text-center">
          Department
        </Table.HeadCell>
        <Table.HeadCell className="whitespace-nowrap text-center">
          Is Active
        </Table.HeadCell>
        <Table.HeadCell className="whitespace-nowrap text-center">
          Image
        </Table.HeadCell>
        <Table.HeadCell className="sticky right-0 whitespace-nowrap bg-gray-100 text-center dark:bg-gray-700">
          Actions
        </Table.HeadCell>
      </Table.Head>
      <Table.Body className="divide-y divide-gray-200 bg-white dark:divide-gray-700 dark:bg-gray-800">
        {adminUsers.map(
          ({
            id,
            name,
            email,
            phone_number,
            birthdate,
            role,
            department,
            is_active,
            image,
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
                align="left"
                className="whitespace-nowrap p-4 text-base font-medium text-gray-900 dark:text-white"
              >
                {email}
              </Table.Cell>
              <Table.Cell
                align="right"
                className="whitespace-nowrap p-4 text-base font-medium text-gray-900 dark:text-white"
              >
                {phone_number}
              </Table.Cell>
              <Table.Cell
                align="right"
                className="whitespace-nowrap p-4 text-base font-medium text-gray-900 dark:text-white"
              >
                {new Date(birthdate).toLocaleDateString('id-Id', {
                  year: 'numeric',
                  month: 'short',
                  day: 'numeric',
                })}
              </Table.Cell>
              <Table.Cell
                align="center"
                className="whitespace-nowrap p-4 text-base font-medium text-gray-900 dark:text-white"
              >
                <Badge color="primary" className="w-fit">
                  {role.name}
                </Badge>
              </Table.Cell>
              <Table.Cell
                align="center"
                className="whitespace-nowrap p-4 text-base font-medium text-gray-900 dark:text-white"
              >
                <Badge color="primary" className="w-fit">
                  {department.name}
                </Badge>
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
              <Table.Cell
                align="center"
                className="whitespace-nowrap p-4 text-base font-medium text-gray-900 dark:text-white"
              >
                <Image
                  alt="images"
                  height={40}
                  src={image}
                  width={40}
                  className="h-[40px] w-[40px] rounded-full"
                />
              </Table.Cell>
              <Table.Cell className="sticky right-0 space-x-2 whitespace-nowrap bg-white p-4 group-hover/row:bg-gray-100 dark:bg-gray-800 dark:group-hover/row:bg-gray-700">
                <div className="flex items-center justify-center gap-x-3">
                  <Button
                    size="sm"
                    color="primary"
                    href={`/admin/user/detail?id=${id}`}
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
