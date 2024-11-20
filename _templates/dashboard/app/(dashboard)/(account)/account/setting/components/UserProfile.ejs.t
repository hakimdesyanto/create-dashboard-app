---
to: src/app/(dashboard)/(account)/account/setting/components/UserProfile.tsx
---
'use client'

import { useLayoutContext } from '@/src/context/LayoutContext'
import { updateAccount } from '@/src/services/base/account'
import {
  uploadImage,
  getImageUrl,
  setFormDataImage,
} from '@/src/services/gudang/image'
import Datepicker from '@/src/packages/ui/datepicker'
import { zodResolver } from '@hookform/resolvers/zod'
import {
  Button,
  Card,
  FileInput,
  Label,
  TextInput,
} from 'flowbite-react'
import Image from 'next/image'
import { useRouter } from 'next/navigation'
import { useEffect, useRef, useState, type FC } from 'react'
import { Controller, useForm } from 'react-hook-form'
import { IoCloudUpload, IoClose } from 'react-icons/io5'
import * as z from 'zod'

const userProfileSchema = z.object({
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
  image: z.string(),
})

type UserProfileSchema = z.infer<typeof userProfileSchema>

const UserProfile: FC<Pick<any, 'userProfile'>> = function ({ userProfile }) {
  const router = useRouter()
  const imageRef = useRef<any>()
  const { toast: { setToast } } = useLayoutContext()
  const [imageLoaded, setImageLoaded] = useState(false)
  const [isProcessingUpload, setIsProcessingUpload] = useState({
    image: false,
  })
  const {
    watch,
    register,
    resetField,
    handleSubmit,
    formState: { errors, isSubmitting, isDirty, isValid, dirtyFields },
    control,
  } = useForm<UserProfileSchema>({
    resolver: zodResolver(userProfileSchema),
    mode: 'onChange',
    defaultValues: {
      name: userProfile?.name,
      email: userProfile?.email,
      phone_number: userProfile?.phone_number,
      birthdate: userProfile?.birthdate
        ? new Date(userProfile.birthdate)
        : new Date(),
      image: userProfile?.image,
    },
  })

  const fetchUpdateAccount = async (data: any): Promise<any> => {
    try {
      const response = await updateAccount(data)
      if (response.status === 200) {
        router.refresh()
        setToast({
          message: 'User profile has been updated',
          show: true,
        })
      } else {
        setToast({
          message: 'User profile failed to update',
          show: true,
        })
      }
    } catch (error: any) {
      throw new Error(error)
    }
  }

  const onSubmit = async (data: UserProfileSchema) => {
    console.log(data)
    fetchUpdateAccount(data)
  }

  useEffect(() => {
    if (isProcessingUpload.image) {
      setImageLoaded(false)
    }
  }, [isProcessingUpload.image])

  return (
    <form
      onSubmit={handleSubmit(onSubmit)}
      className="mb-4 grid grid-cols-1 gap-y-4 xl:mb-0"
    >
      <Card>
        <div className="items-center sm:flex sm:space-x-4 xl:block xl:space-x-0 2xl:flex 2xl:space-x-4">
          <div className="relative w-fit h-fit mb-4 sm:mb-0 xl:mb-4 2xl:mb-0">
            <Image
              alt="avatar"
              height={112}
              src={watch('image', userProfile?.image || '/images/icons/icon_anonymous-user.png')}
              width={112}
              className="w-[112px] h-[112px] object-cover rounded-lg"
              onLoadingComplete={() => setImageLoaded(true)}
              priority
            />
            {(dirtyFields.image && imageLoaded) &&
              <button
                type="button"
                className="absolute bg-primary-700 dark:bg-primary-600 p-1 top-0 right-0 rounded-tr-lg rounded-bl-lg"
                onClick={() => resetField('image')}
              >
                <IoClose className="text-white" />
              </button>
            }
          </div>
          <div>
            <h3 className="mb-1 text-2xl font-bold text-gray-900 dark:text-white">
              {userProfile.name}
            </h3>
            <div className="mb-4 text-base font-normal text-gray-500 dark:text-gray-400">
              {userProfile.role.name}
            </div>
            <Button
              color="light"
              disabled={isProcessingUpload.image}
              onClick={() => imageRef.current.click()}
              isProcessing={isProcessingUpload.image}
            >
              <IoCloudUpload className="mr-2" />
              Change picture
            </Button>
            <Controller
              control={control}
              name="image"
              render={({ field: { value, onChange, ...field } }) => (
                <FileInput
                  {...field}
                  ref={imageRef}
                  accept="image/jpeg, image/png"
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
                  className="hidden"
                />
              )}
            />
          </div>
        </div>
      </Card>
      <Card>
        <h3 className="mb-4 text-xl font-bold dark:text-white">
          General information
        </h3>
        <div className="grid grid-cols-6 gap-6">
          <div className="col-span-6 grid grid-cols-1 gap-y-2 sm:col-span-3">
            <Label htmlFor="name">Name</Label>
            <TextInput
              {...register('name')}
              id="name"
              color="primary"
              helperText={
                errors.name?.message && (
                  <span className="text-red-500">{errors.name?.message}</span>
                )
              }
            />
          </div>
          <div className="col-span-6 grid grid-cols-1 gap-y-2 sm:col-span-3">
            <Label htmlFor="email">Email</Label>
            <TextInput
              {...register('email')}
              id="email"
              color="primary"
              helperText={
                errors.email?.message && (
                  <span className="text-red-500">{errors.email?.message}</span>
                )
              }
              type="email"
            />
          </div>
          <div className="col-span-6 grid grid-cols-1 gap-y-2 sm:col-span-3">
            <Label htmlFor="phone_number">Phone Number</Label>
            <TextInput
              {...register('phone_number')}
              id="phone_number"
              color="primary"
              helperText={
                errors.phone_number?.message && (
                  <span className="text-red-500">{errors.phone_number?.message}</span>
                )
              }
              type="tel"
            />
          </div>
          <div className="col-span-6 grid grid-cols-1 gap-y-2 sm:col-span-3">
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
          <div className="col-span-6 grid grid-cols-1 gap-y-2 sm:col-span-3">
            <Label htmlFor="role">Role</Label>
            <TextInput
              id="role"
              value={userProfile?.role?.name}
              color="primary"
              disabled
            />
          </div>
          <div className="col-span-6 grid grid-cols-1 gap-y-2 sm:col-span-3">
            <Label htmlFor="department">Department</Label>
            <TextInput
              id="department"
              value={userProfile?.department?.name}
              color="primary"
              disabled
            />
          </div>
          <div className="col-span-6">
            <Button
              color="primary"
              type="submit"
              disabled={isSubmitting || !isDirty || !isValid}
            >
              Update
            </Button>
          </div>
        </div>
      </Card>
    </form>
  )
}

export default UserProfile
