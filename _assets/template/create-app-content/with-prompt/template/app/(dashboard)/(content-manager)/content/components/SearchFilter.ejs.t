---
to: src/app/(dashboard)/(content-manager)/<%=contentName%>/components/SearchFilter.tsx
---
import { zodResolver } from '@hookform/resolvers/zod'
import Datepicker from '@/src/packages/ui/datepicker'
import Select from '@/src/packages/ui/select'
import { Button, Label, Modal, Radio, TextInput } from 'flowbite-react'
import omitEmpty from 'omit-empty'
import { useState, type FC } from 'react'
import { Controller, useForm } from 'react-hook-form'
import { FaFilter } from 'react-icons/fa'
import * as z from 'zod'

const filterSchema = z.object({
  filters: z.object({
    id: z.number().optional(),
<% if (isUsingDraftMode) { -%>
    is_draft: z.enum(['all', 'true', 'false']).transform((value) => value !== 'all' ? value === 'true' : undefined),
<% } -%>
<% contentFields.forEach((field) => { -%>
<% switch (field.type) {
case 'text': -%>
    <%=field.name%>: z.string().optional(),
<% break;
case 'number': -%>
    <%=field.name%>: z.number().optional(),
<% break;
case 'select': -%>
    <%=field.name%>: z.number().nullish(),
<% break;
case 'enum': -%>
    <%=field.name%>: z.string().nullish(),
<% break;
case 'date': -%>
    <%=field.name%>: z.date().optional(),
<% break;
case 'boolean': -%>
    <%=field.name%>: z.enum(['all', 'true', 'false']).transform((value) => value !== 'all' ? value === 'true' : undefined),
<% break;
default:
break; } -%>
<% }) -%>
  }).optional(),
  sort: z.object({
    field: z.string().nullish(),
    type: z.string().nullish(),
  }).optional(),
})

type FilterSchema = z.infer<typeof filterSchema>

const SearchFilter: FC<any> = function ({ metadata, setMetadata }) {
  const [isOpen, setOpen] = useState(false)
  const {
    reset,
    register,
    handleSubmit,
    formState: { isSubmitting },
    control,
  } = useForm<FilterSchema>({
    resolver: zodResolver(filterSchema),
    mode: 'onChange',
    defaultValues: {
      filters: {
        id: metadata?.filters?.id,
<% if (isUsingDraftMode) { -%>
        is_draft: metadata?.filters?.is_draft,
<% } -%>
<% contentFields.forEach((field) => { -%>
<% switch (field.type) {
case 'text':
case 'number':
case 'enum':
case 'boolean':
case 'select': -%>
        <%=field.name%>: metadata?.filters?.<%=field.name%>,
<% break;
case 'date': -%>
        <%=field.name%>: metadata?.filters?.<%=field.name%>
          ? new Date(metadata.filters.<%=field.name%>)
          : undefined,
<% break;
default:
break; } -%>
<% }) -%>
      },
      sort: {
        field: metadata?.sort?.field,
        type: metadata?.sort?.type,
      }
    },
  })

  const onSubmit = async (data: FilterSchema) => {
    console.log(data)
    setMetadata((prevState: any) => ({
      ...prevState,
      filters: data?.filters,
      sort: data?.sort,
      pagination: {
        ...prevState.pagination,
        page: 1,
      },
    }))
    setOpen(false)
  }

  return (
    <>
      <Button
        color="light"
        className={
          Object.keys(
            omitEmpty({ filters: metadata?.filters, sort: metadata?.sort }),
          ).length > 0
            ? 'text-primary-600 dark:text-primary-500'
            : ''
        }
        onClick={() => setOpen(!isOpen)}
      >
        <FaFilter className="mr-3 text-sm" />
        Filter
      </Button>
      <Modal onClose={() => setOpen(false)} show={isOpen}>
        <form
          onSubmit={handleSubmit(onSubmit)}
          className="relative flex max-h-[90vh] flex-col"
        >
          <Modal.Header className="border-b border-gray-200 dark:border-gray-700">
            Search Filter
          </Modal.Header>
          <Modal.Body className="grid grid-cols-1 gap-6">
            <div className="grid grid-cols-1 gap-6 sm:grid-cols-2">
              <div className="flex flex-col gap-2">
                <Label htmlFor="filters.id">ID</Label>
                <TextInput
                  {...register('filters.id', {
                    setValueAs: (value) => value ? Number(value) : undefined 
                  })}
                  id="filters.id"
                  color="primary"
                  type="number"
                />
              </div>
<% if (isUsingDraftMode) { -%>
              <div className="flex flex-col gap-2">
                <Label>State</Label>
                <div className="flex h-full flex-wrap gap-4">
                  <div className="flex items-center gap-2">
                    <Radio
                      {...register('filters.is_draft', {
                        setValueAs: (value) => (value ? value : 'all'),
                      })}
                      id="filters.is_draft_all"
                      value="all"
                    />
                    <Label htmlFor="filters.is_draft_all">All</Label>
                  </div>
                  <div className="flex items-center gap-2">
                    <Radio
                      {...register('filters.is_draft', {
                        setValueAs: (value) => (value ? value : 'all'),
                      })}
                      id="filters.is_draft_true"
                      value="true"
                    />
                    <Label htmlFor="filters.is_draft_true">Draft</Label>
                  </div>
                  <div className="flex items-center gap-2">
                    <Radio
                      {...register('filters.is_draft', {
                        setValueAs: (value) => (value ? value : 'all'),
                      })}
                      id="filters.is_draft_false"
                      value="false"
                    />
                    <Label htmlFor="filters.is_draft_false">Publish</Label>
                  </div>
                </div>
              </div>
<% } -%>
<% contentFields.forEach((field) => { -%>
<% switch (field.type) {
case 'text': -%>
              <div className="flex flex-col gap-2">
                <Label htmlFor="filters.<%=field.name%>"><%=h.changeCase.titleCase(field.name)%></Label>
                <TextInput
                  {...register('filters.<%=field.name%>', { setValueAs: (value) => value ?? undefined })}
                  id="filters.<%=field.name%>"
                  color="primary"
                />
              </div>
<% break;
case 'number': -%>
              <div className="flex flex-col gap-2">
                <Label htmlFor="filters.<%=field.name%>"><%=h.changeCase.titleCase(field.name)%></Label>
                <TextInput
                  {...register('filters.<%=field.name%>', {
                    setValueAs: (value) => value ? Number(value) : undefined 
                  })}
                  id="filters.<%=field.name%>"
                  color="primary"
                  type="number"
                />
              </div>
<% break;
case 'select': -%>
              <div className="flex flex-col gap-2">
                <Label htmlFor="filters.<%=field.name%>"><%=h.changeCase.titleCase(field.name)%></Label>
                <Controller
                  control={control}
                  name="filters.<%=field.name%>"
                  render={({ field: { value, onChange } }) => {
                    const options = [
                      { value: 1, label: "Option 1" },
                      { value: 2, label: "Option 2" },
                      { value: 3, label: "Option 3" },
                    ]
                    return (
                      <Select
                        id="filters.<%=field.name%>"
                        value={options.find((option) => option.value === value)}
                        onChange={(option: any) => {
                          onChange(option?.value ?? null)
                        }}
                        placeholder="Choose a <%=h.changeCase.titleCase(field.name)%>"
                        options={options}
                      />
                    )
                  }}
                />
              </div>
<% break;
case 'enum': -%>
              <div className="flex flex-col gap-2">
                <Label><%=h.changeCase.titleCase(field.name)%></Label>
                <div className="flex flex-wrap gap-4 h-full">
                  <div className="flex items-center gap-2">
                    <Radio {...register('filters.<%=field.name%>')} id="filters.<%=field.name%>_1" value="Option 1" />
                    <Label htmlFor="filters.<%=field.name%>_1">Option 1</Label>
                  </div>
                  <div className="flex items-center gap-2">
                    <Radio {...register('filters.<%=field.name%>')} id="filters.<%=field.name%>_2" value="Option 2" />
                    <Label htmlFor="filters.<%=field.name%>_2">Option 2</Label>
                  </div>
                  <div className="flex items-center gap-2">
                    <Radio {...register('filters.<%=field.name%>')} id="filters.<%=field.name%>_3" value="Option 3" />
                    <Label htmlFor="filters.<%=field.name%>_3">Option 3</Label>
                  </div>
                </div>
              </div>
<% break;
case 'date': -%>
              <div className="flex flex-col gap-2">
                <Label htmlFor="filters.<%=field.name%>"><%=h.changeCase.titleCase(field.name)%></Label>
                <Controller
                  control={control}
                  name="filters.<%=field.name%>"
                  render={({ field: { value, onChange } }) => (
                    <Datepicker
                      id="filters.<%=field.name%>"
                      value={value}
                      onChange={onChange}
                    />
                  )}
                />
              </div>
<% break;
case 'boolean': -%>
              <div className="flex flex-col gap-2">
                <Label><%=h.changeCase.titleCase(field.name)%></Label>
                <div className="flex h-full flex-wrap gap-4">
                  <div className="flex items-center gap-2">
                    <Radio
                      {...register('filters.<%=field.name%>', {
                        setValueAs: (value) => (value ? value : 'all'),
                      })}
                      id="filters.<%=field.name%>_all"
                      value="all"
                    />
                    <Label htmlFor="filters.<%=field.name%>_all">All</Label>
                  </div>
                  <div className="flex items-center gap-2">
                    <Radio
                      {...register('filters.<%=field.name%>', {
                        setValueAs: (value) => (value ? value : 'all'),
                      })}
                      id="filters.<%=field.name%>_true"
                      value="true"
                    />
                    <Label htmlFor="filters.<%=field.name%>_true">True</Label>
                  </div>
                  <div className="flex items-center gap-2">
                    <Radio
                      {...register('filters.<%=field.name%>', {
                        setValueAs: (value) => (value ? value : 'all'),
                      })}
                      id="filters.<%=field.name%>_false"
                      value="false"
                    />
                    <Label htmlFor="filters.<%=field.name%>_false">False</Label>
                  </div>
                </div>
              </div>
<% break;
default:
break; } -%>
<% }) -%>
            </div>
            <div className="grid grid-cols-1 gap-6 sm:grid-cols-2">
              <div className="flex flex-col gap-2">
                <Label htmlFor="sort.field">Sort By</Label>
                <Controller
                  control={control}
                  name="sort.field"
                  render={({ field: { value, onChange } }) => {
                    const options = [
                      { value: "id", label: "ID" },
<% contentFields.forEach((field) => { -%>
<% if (field.type !== 'longtext' && field.type !== 'richtext' && field.type !== 'image' && field.type !== 'json') { -%>
                      { value: "<%=field.name%>", label: "<%=h.changeCase.titleCase(field.name)%>" },
<% } -%>
<% }) -%>
                    ]
                    return (
                      <Select
                        id="sort.field"
                        value={options.find((option) => option.value === value)}
                        onChange={(option: any) => {
                          onChange(option?.value ?? null)
                        }}
                        placeholder="Choose a Sort By"
                        options={options}
                      />
                    )
                  }}
                />
              </div>
              <div className="flex flex-col gap-2">
                <Label htmlFor="sort.type">Sort Type</Label>
                <Controller
                  control={control}
                  name="sort.type"
                  render={({ field: { value, onChange } }) => {
                    const options = [
                      { value: "asc", label: "ASC" },
                      { value: "desc", label: "DESC" },
                    ]
                    return (
                      <Select
                        id="sort.type"
                        value={options.find((option) => option.value === value)}
                        onChange={(option: any) => {
                          onChange(option?.value ?? null)
                        }}
                        placeholder="Choose a Sort Type"
                        options={options}
                      />
                    )
                  }}
                />
              </div>
            </div>
          </Modal.Body>
          <Modal.Footer>
            <Button
              color="light"
              type="button"
              onClick={() => { reset() }}
            >
              Reset
            </Button>
            <Button
              color="primary"
              type="submit"
              disabled={isSubmitting}
            >
              Apply
            </Button>
          </Modal.Footer>
        </form>
      </Modal>
    </>
  );
}

export default SearchFilter
