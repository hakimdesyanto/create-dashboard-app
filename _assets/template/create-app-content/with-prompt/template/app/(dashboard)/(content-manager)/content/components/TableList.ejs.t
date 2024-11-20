---
to: src/app/(dashboard)/(content-manager)/<%=contentName%>/components/TableList.tsx
---
import { Badge, Button, Table } from 'flowbite-react'
import Image from 'next/image'
import type { FC } from 'react'
import { HiCheck, HiPencilAlt, HiX } from 'react-icons/hi'

const TableList: FC<any> = function ({ <%=h.changeCase.camelCase(h.inflection.pluralize(contentName))%> }) {
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
      <Table.Head className="bg-gray-100 dark:bg-gray-700 sticky top-0 z-10">
        <Table.HeadCell className="whitespace-nowrap">ID</Table.HeadCell>
<% if (isUsingDraftMode) { -%>
        <Table.HeadCell className="whitespace-nowrap text-center">State</Table.HeadCell>
<% } -%>
<% contentFields.forEach((field) => { -%>
<% switch (field.type) {
case 'text': -%>
        <Table.HeadCell className="whitespace-nowrap text-left">
          <%=h.changeCase.titleCase(field.name)%>
        </Table.HeadCell>
<% break;
case 'number': -%>
        <Table.HeadCell className="whitespace-nowrap text-right">
          <%=h.changeCase.titleCase(field.name)%>
        </Table.HeadCell>
<% break;
case 'date':
case 'select':
case 'enum':
case 'boolean':
case 'image': -%>
        <Table.HeadCell className="whitespace-nowrap text-center">
          <%=h.changeCase.titleCase(field.name)%>
        </Table.HeadCell>
<% break;
default:
break; } -%>
<% }) -%>
        <Table.HeadCell className="whitespace-nowrap text-center sticky right-0 bg-gray-100 dark:bg-gray-700">
          Actions
        </Table.HeadCell>
      </Table.Head>
      <Table.Body className="divide-y divide-gray-200 bg-white dark:divide-gray-700 dark:bg-gray-800">
        {<%=h.changeCase.camelCase(h.inflection.pluralize(contentName))%>.map(({
          id,
<% if (isUsingDraftMode) { -%>
          is_draft,
<% } -%>
<% contentFields.forEach((field) => { -%>
<% if (field.type !== 'longtext' && field.type !== 'richtext' && field.type !== 'json') { -%>
          <%=field.name%>,
<% } -%>
<% }) -%>
        }: any, i: number) => (
          <Table.Row
            key={i}
            className="hover:bg-gray-100 dark:hover:bg-gray-700"
          >
            <Table.Cell className="whitespace-nowrap p-4 text-base font-medium text-gray-900 dark:text-white">
              {id}
            </Table.Cell>
<% if (isUsingDraftMode) { -%>
            <Table.Cell
              align="center"
              className="whitespace-nowrap p-4 text-base font-medium text-gray-900 dark:text-white"
            >
              <Badge className="w-fit" color={is_draft ? 'warning' : 'success'}>
                {is_draft ? 'DRAFT' : 'PUBLISHED'}
              </Badge>
            </Table.Cell>
<% } -%>
<% contentFields.forEach((field) => { -%>
<% switch (field.type) {
case 'text': -%>
            <Table.Cell align="left" className="whitespace-nowrap p-4 text-base font-medium text-gray-900 dark:text-white">
              {<%=field.name%>}
            </Table.Cell>
<% break;
case 'number': -%>
            <Table.Cell align="right" className="whitespace-nowrap p-4 text-base font-medium text-gray-900 dark:text-white">
              {new Intl.NumberFormat('id-ID').format(<%=field.name%>)}
            </Table.Cell>
<% break;
case 'date': -%>
            <Table.Cell align="center" className="whitespace-nowrap p-4 text-base font-medium text-gray-900 dark:text-white">
              {new Date(<%=field.name%>).toLocaleDateString('id-Id', {
                year: 'numeric',
                month: 'short',
                day: 'numeric',
              })}
            </Table.Cell>
<% break;
case 'select': -%>
            <Table.Cell align="center" className="whitespace-nowrap p-4 text-base font-medium text-gray-900 dark:text-white">
              <Badge color="primary" className="w-fit">{<%=field.name%>.name}</Badge>
            </Table.Cell>
<% break;
case 'enum': -%>
            <Table.Cell align="center" className="whitespace-nowrap p-4 text-base font-medium text-gray-900 dark:text-white">
              <Badge color="primary" className="w-fit">{<%=field.name%>}</Badge>
            </Table.Cell>
<% break;
case 'boolean': -%>
            <Table.Cell align="center" className="whitespace-nowrap p-4 text-base font-medium text-gray-900 dark:text-white">
              {<%=field.name%> ? <HiCheck className="text-green-500 font-bold" /> : <HiX className="text-red-500" />}
            </Table.Cell>
<% break;
case 'image': -%>
            <Table.Cell align="center" className="whitespace-nowrap p-4 text-base font-medium text-gray-900 dark:text-white">
              <Image
                alt="<%=field.name%>"
                height={40}
                src={<%=field.name%>}
                width={40}
                className="rounded-full h-[40px] w-[40px]"
              />
            </Table.Cell>
<% break;
default:
break; } -%>
<% }) -%>
            <Table.Cell className="space-x-2 whitespace-nowrap p-4 sticky right-0 bg-white dark:bg-gray-800 group-hover/row:bg-gray-100 dark:group-hover/row:bg-gray-700">
              <div className="flex justify-center items-center gap-x-3">
                <Button
                  size="sm"
                  color="primary"
                  href={`/<%=contentName%>/detail?id=${id}`}
                >
                  <HiPencilAlt className="mr-2 h-5 w-5" />
                  Edit
                </Button>
              </div>
            </Table.Cell>
          </Table.Row>
        ))}
      </Table.Body>
    </Table>
  )
}

export default TableList
