---
to: src/app/(dashboard)/(administrators)/admin/role/components/SearchFilter.tsx
---
import Select from '@/src/packages/ui/select'
import { zodResolver } from '@hookform/resolvers/zod'
import { Button, Label, Modal, Radio, TextInput } from 'flowbite-react'
import omitEmpty from 'omit-empty'
import { useState, type FC } from 'react'
import { Controller, useForm } from 'react-hook-form'
import { FaFilter } from 'react-icons/fa'
import * as z from 'zod'

const filterSchema = z.object({
  filters: z
    .object({
      id: z.number().optional(),
      name: z.string().optional(),
      is_active: z
        .enum(['all', 'true', 'false'])
        .transform((value) => (value !== 'all' ? value === 'true' : undefined)),
    })
    .optional(),
  sort: z
    .object({
      field: z.string().nullish(),
      type: z.string().nullish(),
    })
    .optional(),
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
        name: metadata?.filters?.name,
        is_active: metadata?.filters?.is_active ?? 'all',
      },
      sort: {
        field: metadata?.sort?.field ?? null,
        type: metadata?.sort?.type ?? null,
      },
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
                    setValueAs: (value) => (value ? Number(value) : undefined),
                  })}
                  id="filters.id"
                  color="primary"
                  type="number"
                />
              </div>
              <div className="flex flex-col gap-2">
                <Label htmlFor="filters.name">Name</Label>
                <TextInput
                  {...register('filters.name', {
                    setValueAs: (value) => value ?? undefined,
                  })}
                  id="filters.name"
                  color="primary"
                />
              </div>
              <div className="flex flex-col gap-2">
                <Label>Is Active</Label>
                <div className="flex h-full flex-wrap gap-4">
                  <div className="flex items-center gap-2">
                    <Radio
                      {...register('filters.is_active', {
                        setValueAs: (value) => (value ? value : 'all'),
                      })}
                      id="filters.is_active_all"
                      value="all"
                    />
                    <Label htmlFor="filters.is_active_all">All</Label>
                  </div>
                  <div className="flex items-center gap-2">
                    <Radio
                      {...register('filters.is_active', {
                        setValueAs: (value) => (value ? value : 'all'),
                      })}
                      id="filters.is_active_true"
                      value="true"
                    />
                    <Label htmlFor="filters.is_active_true">True</Label>
                  </div>
                  <div className="flex items-center gap-2">
                    <Radio
                      {...register('filters.is_active', {
                        setValueAs: (value) => (value ? value : 'all'),
                      })}
                      id="filters.is_active_false"
                      value="false"
                    />
                    <Label htmlFor="filters.is_active_false">False</Label>
                  </div>
                </div>
              </div>
            </div>
            <div className="grid grid-cols-1 gap-6 sm:grid-cols-2">
              <div className="flex flex-col gap-2">
                <Label htmlFor="sort.field">Sort By</Label>
                <Controller
                  control={control}
                  name="sort.field"
                  render={({ field: { value, onChange } }) => {
                    const options = [
                      { value: 'id', label: 'ID' },
                      { value: 'name', label: 'Name' },
                      { value: 'is_active', label: 'Is Active' },
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
                      { value: 'asc', label: 'ASC' },
                      { value: 'desc', label: 'DESC' },
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
              onClick={() => {
                reset()
              }}
            >
              Reset
            </Button>
            <Button color="primary" type="submit" disabled={isSubmitting}>
              Apply
            </Button>
          </Modal.Footer>
        </form>
      </Modal>
    </>
  )
}

export default SearchFilter
