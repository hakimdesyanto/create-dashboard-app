---
to: src/app/(dashboard)/(administrators)/admin/role/components/ContentForm.tsx
---
'use client'

import { CancelButton, SubmitButton } from '@/src/components/confirm-button'
import { useLayoutContext } from '@/src/context/LayoutContext'
import {
  getAdminRolePermissions,
  addAdminRole,
  updateAdminRole
} from '@/src/services/base/admin/role'
import { zodResolver } from '@hookform/resolvers/zod'
import { Card, Checkbox, Label, TextInput, ToggleSwitch } from 'flowbite-react'
import { useRouter } from 'next/navigation'
import { useEffect, useState, type FC } from 'react'
import { Controller, useForm } from 'react-hook-form'
import * as z from 'zod'

const contentSchema = z.object({
  name: z.string().min(1, { message: 'Role name is required' }),
  permissions: z.array(z.number()).default([]),
  is_active: z.boolean(),
})

type ContentSchema = z.infer<typeof contentSchema>

const ContentForm: FC<any> = function ({ adminRole }) {
  const mode = adminRole ? 'edit' : 'create'
  const router = useRouter()
  const { toast: { setToast } } = useLayoutContext()
  const [adminRolePermissions, setAdminRolePermissions] = useState([])
  const [checkedPermissionIds, setCheckedPermissionIds] = useState(
    adminRole?.permissions || [],
  )
  const {
    register,
    setValue,
    handleSubmit,
    formState: { errors, isSubmitting, isDirty, isValid },
    control,
  } = useForm<ContentSchema>({
    resolver: zodResolver(contentSchema),
    mode: 'onChange',
    defaultValues: {
      name: adminRole?.name,
      permissions: adminRole?.permissions,
      is_active: adminRole?.is_active || false,
    },
  })

  const fetchGetAdminRolePermissions = async (): Promise<any> => {
    try {
      const response = await getAdminRolePermissions()
      if (response.status === 200) {
        setAdminRolePermissions(response.data.data)
      } else {
        setToast({
          message: 'Failed to get Admin Role Permissions data',
          show: true,
        })
      }
    } catch (error: any) {
      throw new Error(error)
    }
  }

  const fetchAddAdminRole = async (data: any): Promise<any> => {
    try {
      const response = await addAdminRole(data)
      if (response.status === 201) {
        router.push('/admin/role')
        setToast({
          message: 'Admin Role has been added',
          show: true,
        })
      } else {
        setToast({
          message: 'Admin Role failed to add',
          show: true,
        })
      }
    } catch (error: any) {
      throw new Error(error)
    }
  }

  const fetchUpdateAdminRole = async (data: any): Promise<any> => {
    try {
      const response = await updateAdminRole(adminRole.id, data)
      if (response.status === 200) {
        router.push('/admin/role')
        setToast({
          message: 'Admin Role has been updated',
          show: true,
        })
      } else {
        setToast({
          message: 'Admin Role failed to update',
          show: true,
        })
      }
    } catch (error: any) {
      throw new Error(error)
    }
  }

  const onSubmit = async (data: ContentSchema) => {
    console.log(data)
    if (mode === 'create') {
      await fetchAddAdminRole(data)
    } else {
      await fetchUpdateAdminRole(data)
    }
  }

  useEffect(() => {
    fetchGetAdminRolePermissions()
  }, [])

  return (
    <div className="flex flex-col gap-4">
      <form id="admin-role-form" onSubmit={handleSubmit(onSubmit)}>
        <div className="grid grid-cols-1 items-start gap-6 lg:grid-cols-3">
          <Card className="col-span-3 lg:col-span-2">
            <h3 className="mb-4 text-xl font-bold dark:text-white">Detail</h3>
            <div className="mb-6 grid grid-cols-1 gap-6">
              <div className="col-span-1 grid grid-cols-1 gap-y-4">
                <div className="grid grid-cols-1 gap-y-2">
                  <Label htmlFor="name">Role Name</Label>
                  <TextInput
                    {...register('name')}
                    id="name"
                    color="primary"
                    helperText={
                      errors.name?.message && (
                        <span className="text-red-500">
                          {errors.name?.message}
                        </span>
                      )
                    }
                  />
                </div>
                <div className="grid grid-cols-1 gap-y-2">
                  <Label>Permissions</Label>
                  <div className="grid grid-cols-1 gap-4 md:grid-cols-2 lg:grid-cols-2">
                    {adminRolePermissions.map((permission: any, i: number) => (
                      <div
                        key={permission.slug}
                        className="flex flex-col gap-2 rounded-lg border border-gray-300 p-4 dark:border-gray-600"
                      >
                        <div className="flex items-center gap-2">
                          <Checkbox
                            id={permission.slug}
                            checked={permission.actions.every((action: any) =>
                              checkedPermissionIds.includes(action.id),
                            )}
                            onChange={() => {
                              const isChecked = permission.actions.every(
                                (action: any) =>
                                  checkedPermissionIds.includes(action.id),
                              )
                              let newCheckedPermissionIds: any = [
                                ...checkedPermissionIds,
                              ]
                              permission.actions.map((action: any) => {
                                if (isChecked) {
                                  newCheckedPermissionIds =
                                    newCheckedPermissionIds?.filter(
                                      (id: number) => id !== action.id,
                                    )
                                } else {
                                  newCheckedPermissionIds =
                                    !newCheckedPermissionIds.includes(action.id)
                                      ? [...newCheckedPermissionIds, action.id]
                                      : newCheckedPermissionIds
                                }
                              })
                              setCheckedPermissionIds(newCheckedPermissionIds)
                              setValue('permissions', newCheckedPermissionIds, {
                                shouldDirty: true,
                              })
                            }}
                          />
                          <Label htmlFor={permission.slug} className="flex">
                            {permission.name}
                          </Label>
                        </div>
                        <div className="ml-4 flex flex-col gap-2">
                          {permission.actions.map((action: any, j: number) => (
                            <div
                              key={`${permission.slug}-${action.slug}`}
                              className="flex items-center gap-2"
                            >
                              <Controller
                                control={control}
                                name="permissions"
                                render={({ field: { onChange } }) => (
                                  <>
                                    <Checkbox
                                      id={`${permission.slug}-${action.slug}`}
                                      checked={checkedPermissionIds.includes(
                                        action.id,
                                      )}
                                      value={action.id}
                                      onChange={() => {
                                        const newCheckedPermissionIds =
                                          checkedPermissionIds?.includes(
                                            action.id,
                                          )
                                            ? checkedPermissionIds?.filter(
                                                (id: number) =>
                                                  id !== action.id,
                                              )
                                            : [
                                                ...checkedPermissionIds,
                                                action.id,
                                              ]
                                        setCheckedPermissionIds(
                                          newCheckedPermissionIds,
                                        )
                                        onChange(newCheckedPermissionIds)
                                      }}
                                    />
                                    <Label
                                      htmlFor={`${permission.slug}-${action.slug}`}
                                    >
                                      {action.name}
                                    </Label>
                                  </>
                                )}
                              />
                            </div>
                          ))}
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
                <div className="grid grid-cols-1 gap-y-2">
                  <Label htmlFor="is_active">Is Active</Label>
                  <Controller
                    control={control}
                    name="is_active"
                    render={({ field: { value, onChange } }) => (
                      <ToggleSwitch
                        id="is_active"
                        className="w-fit"
                        color="primary"
                        checked={value}
                        onChange={onChange}
                      />
                    )}
                  />
                </div>
              </div>
            </div>
            <div className="flex gap-4">
              <CancelButton href="/admin/role">Cancel</CancelButton>
              <SubmitButton
                form="admin-role-form"
                disabled={isSubmitting || !isDirty || !isValid}
              >
                Submit
              </SubmitButton>
            </div>
          </Card>
        </div>
      </form>
    </div>
  )
}

export default ContentForm
