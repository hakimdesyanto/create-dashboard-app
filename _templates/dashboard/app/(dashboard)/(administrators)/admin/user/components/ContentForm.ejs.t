---
to: src/app/(dashboard)/(administrators)/admin/user/components/ContentForm.tsx
---
'use client'

import { CancelButton, SubmitButton } from '@/src/components/confirm-button'
import { useLayoutContext } from '@/src/context/LayoutContext'
import {
  addAdminUser,
  updateAdminUser
} from '@/src/services/base/admin/user'
import {
  uploadImage,
  getImageUrl,
  setFormDataImage,
} from '@/src/services/gudang/image'
import Datepicker from '@/src/packages/ui/datepicker'
import FileInput from '@/src/packages/ui/file-input'
import Select from '@/src/packages/ui/select'
import { zodResolver } from '@hookform/resolvers/zod'
import { Card, Label, TextInput, ToggleSwitch } from 'flowbite-react'
import { useRouter } from 'next/navigation'
import { useState, type FC } from 'react'
import { Controller, useForm } from 'react-hook-form'
import * as z from 'zod'

const contentSchema = z.object({
  name: z.string().min(1, { message: 'Name is required' }),
  email: z
    .string()
    .min(1, { message: 'Email is required' })
    .email('Email is not valid'),
  phone_number: z.string().refine((value) => /^\d{10,}$/g.test(value), {
    message:
      'Invalid phone number format. Please enter at least a 10-digit number.',
  }),
  birthdate: z.date(),
  role: z.number({ invalid_type_error: 'Role is required' }),
  department: z.number({ invalid_type_error: 'Department is required' }),
  is_active: z.boolean(),
  image: z.string({ required_error: 'Image is required' }),
})

type ContentSchema = z.infer<typeof contentSchema>

const ContentForm: FC<any> = function ({ adminUser }) {
  const mode = adminUser ? 'edit' : 'create'
  const router = useRouter()
  const { toast: { setToast } } = useLayoutContext()
  const [isProcessingUpload, setIsProcessingUpload] = useState({
    image: false,
  })
  const {
    register,
    resetField,
    handleSubmit,
    formState: { errors, isSubmitting, isDirty, isValid, dirtyFields },
    control,
  } = useForm<ContentSchema>({
    resolver: zodResolver(contentSchema),
    mode: 'onChange',
    defaultValues: {
      name: adminUser?.name,
      email: adminUser?.email,
      phone_number: adminUser?.phone_number,
      birthdate: adminUser?.birthdate
        ? new Date(adminUser.birthdate)
        : new Date(),
      role: adminUser?.role?.id,
      department: adminUser?.department?.id,
      is_active: adminUser?.is_active || false,
      image: adminUser?.image,
    },
  })

  const fetchAddAdminUser = async (data: any): Promise<any> => {
    try {
      const response = await addAdminUser(data)
      if (response.status === 201) {
        router.push('/admin/user')
        setToast({
          message: 'Admin User has been added',
          show: true,
        })
      } else {
        setToast({
          message: 'Admin User failed to add',
          show: true,
        })
      }
    } catch (error: any) {
      throw new Error(error)
    }
  }

  const fetchUpdateAdminUser = async (data: any): Promise<any> => {
    try {
      const response = await updateAdminUser(adminUser.id, data)
      if (response.status === 200) {
        router.push('/admin/user')
        setToast({
          message: 'Admin User has been updated',
          show: true,
        })
      } else {
        setToast({
          message: 'Admin User failed to update',
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
      await fetchAddAdminUser(data)
    } else {
      await fetchUpdateAdminUser(data)
    }
  }

  return (
    <div className="flex flex-col gap-4">
      <form id="admin-user-form" onSubmit={handleSubmit(onSubmit)}>
        <div className="grid grid-cols-1 items-start gap-6 lg:grid-cols-3">
          <Card className="col-span-3 lg:col-span-2">
            <h3 className="mb-4 text-xl font-bold dark:text-white">Detail</h3>
            <div className="mb-6 grid grid-cols-1 gap-6">
              <div className="col-span-1 grid grid-cols-1 gap-y-4">
                <div className="grid grid-cols-1 gap-y-2">
                  <Label htmlFor="name">Name</Label>
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
                  <Label htmlFor="email">Email</Label>
                  <TextInput
                    {...register('email')}
                    id="email"
                    color="primary"
                    type="email"
                    helperText={
                      errors.email?.message && (
                        <span className="text-red-500">
                          {errors.email?.message}
                        </span>
                      )
                    }
                  />
                </div>
                <div className="grid grid-cols-1 gap-y-2">
                  <Label htmlFor="phone_number">Phone Number</Label>
                  <TextInput
                    {...register('phone_number')}
                    id="phone_number"
                    color="primary"
                    type="tel"
                    helperText={
                      errors.phone_number?.message && (
                        <span className="text-red-500">
                          {errors.phone_number?.message}
                        </span>
                      )
                    }
                  />
                </div>
                <div className="grid grid-cols-1 gap-y-2">
                  <Label htmlFor="birthdate">Birthdate</Label>
                  <Controller
                    control={control}
                    name="birthdate"
                    render={({ field: { value, onChange } }) => (
                      <Datepicker
                        id="birthdate"
                        value={value}
                        onChange={onChange}
                        helperText={
                          errors.birthdate?.message && (
                            <span className="text-red-500">
                              {errors.birthdate?.message}
                            </span>
                          )
                        }
                      />
                    )}
                  />
                </div>
                <div className="grid grid-cols-1 gap-y-2">
                  <Label htmlFor="role">Role</Label>
                  <Controller
                    control={control}
                    name="role"
                    render={({ field: { value, onChange } }) => {
                      const options = [
                        { value: 1, label: 'Superadmin' },
                        { value: 2, label: 'Crowdfunding Ops' },
                        { value: 3, label: 'Insurance Ops' },
                      ]
                      return (
                        <Select
                          id="role"
                          value={options.find(
                            (option) => option.value === value,
                          )}
                          onChange={(option: any) => {
                            onChange(option?.value ?? null)
                          }}
                          placeholder="Choose a Role"
                          options={options}
                          helperText={
                            errors.role?.message && (
                              <span className="text-red-500">
                                {errors.role?.message}
                              </span>
                            )
                          }
                        />
                      )
                    }}
                  />
                </div>
                <div className="grid grid-cols-1 gap-y-2">
                  <Label htmlFor="department">Department</Label>
                  <Controller
                    control={control}
                    name="department"
                    render={({ field: { value, onChange } }) => {
                      const options = [
                        { value: 1, label: 'Business' },
                        { value: 2, label: 'Engineering' },
                        { value: 3, label: 'Product' },
                      ]
                      return (
                        <Select
                          id="department"
                          value={options.find(
                            (option) => option.value === value,
                          )}
                          onChange={(option: any) => {
                            onChange(option?.value ?? null)
                          }}
                          placeholder="Choose a Department"
                          options={options}
                          helperText={
                            errors.department?.message && (
                              <span className="text-red-500">
                                {errors.department?.message}
                              </span>
                            )
                          }
                        />
                      )
                    }}
                  />
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
                <div className="grid grid-cols-1 gap-y-2">
                  <Label>Image</Label>
                  <Controller
                    control={control}
                    name="image"
                    render={({ field: { onChange, ...field } }) => (
                      <FileInput
                        { ...field }
                        id="image"
                        accept="image/jpeg, image/png"
                        isProcessingUpload={isProcessingUpload.image}
                        allowDelete={dirtyFields.image}
                        onDelete={() => resetField('image')}
                        onChange={async (e: any) => {
                          if (e.target.files.length > 0) {
                            try {
                              setIsProcessingUpload((prevState) => ({
                                ...prevState,
                                image: true,
                              }))
                              const data = setFormDataImage(e.target.files[0])
                              const response = await uploadImage(data)
                              if (response.status === 200) {
                                onChange(getImageUrl(response.data.data[0].full_path))
                              } else {
                                setToast({
                                  message: 'Failed to upload image',
                                  show: true,
                                })
                              }
                              setIsProcessingUpload((prevState) => ({
                                ...prevState,
                                image: false,
                              }))
                            } catch (error: any) {
                              throw new Error(error)
                            }
                          }
                        }}
                        helperText={
                          errors.image?.message && (
                            <span className="text-red-500">
                              {errors.image?.message}
                            </span>
                          )
                        }
                      />
                    )}
                  />
                </div>
              </div>
            </div>
            <div className="flex gap-4">
              <CancelButton href="/admin/user">Cancel</CancelButton>
              <SubmitButton
                form="admin-user-form"
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
