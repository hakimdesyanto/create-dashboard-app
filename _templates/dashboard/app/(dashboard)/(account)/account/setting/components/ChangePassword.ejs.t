---
to: src/app/(dashboard)/(account)/account/setting/components/ChangePassword.tsx
---
'use client'

import { useLayoutContext } from '@/src/context/LayoutContext'
import { changePasswordAccount } from '@/src/services/base/account'
import { zodResolver } from '@hookform/resolvers/zod'
import { Button, Card, Label, TextInput } from 'flowbite-react'
import { useRouter } from 'next/navigation'
import type { FC } from 'react'
import { useForm } from 'react-hook-form'
import * as z from 'zod'

const changePasswordSchema = z
  .object({
    old_password: z.string().min(1, { message: 'Old password is required' }),
    new_password: z
      .string()
      .min(10, { message: 'Please enter at least 10 character' }),
    confirm_password: z.string(),
  })
  .refine((data) => data.new_password === data.confirm_password, {
    message: 'New password and confirm password do not match',
    path: ['confirm_password'],
  })

type ChangePasswordSchema = z.infer<typeof changePasswordSchema>

const ChangePassword: FC = function () {
  const router = useRouter()
  const { toast: { setToast } } = useLayoutContext()
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting, isDirty, isValid },
  } = useForm<ChangePasswordSchema>({
    resolver: zodResolver(changePasswordSchema),
    mode: 'onChange',
  })

  const fetchChangePasswordAccount = async (data: any): Promise<any> => {
    try {
      const response = await changePasswordAccount(data)
      if (response.status === 200) {
        router.refresh()
        setToast({
          message: 'Your password has been changed successfully',
          show: true,
        })
      } else {
        setToast({
          message: 'Your password failed to change',
          show: true,
        })
      }
    } catch (error: any) {
      throw new Error(error)
    }
  }

  const onSubmit = async (data: ChangePasswordSchema) => {
    console.log(data)
    fetchChangePasswordAccount(data)
  }

  return (
    <Card>
      <h3 className="mb-4 text-xl font-bold dark:text-white">
        Password information
      </h3>
      <form onSubmit={handleSubmit(onSubmit)}>
        <div className="grid grid-cols-6 gap-6">
          <div className="col-span-6 grid grid-cols-1 gap-y-2 sm:col-span-3">
            <Label htmlFor="old_password">Current password</Label>
            <TextInput
              {...register('old_password')}
              id="old_password"
              color="primary"
              helperText={
                errors.old_password?.message && (
                  <span className="text-red-500">
                    {errors.old_password?.message}
                  </span>
                )
              }
              placeholder="••••••••"
              type="password"
            />
          </div>
          <div className="col-span-6 grid grid-cols-1 gap-y-2 sm:col-span-3">
            <Label htmlFor="new_password">New password</Label>
            <TextInput
              {...register('new_password')}
              id="new_password"
              color="primary"
              helperText={
                errors.new_password?.message && (
                  <span className="text-red-500">
                    {errors.new_password?.message}
                  </span>
                )
              }
              placeholder="••••••••"
              type="password"
            />
          </div>
          <div className="col-span-6 grid grid-cols-1 gap-y-2 sm:col-span-3">
            <Label htmlFor="confirm_password">Confirm password</Label>
            <TextInput
              {...register('confirm_password')}
              id="confirm_password"
              color="primary"
              helperText={
                errors.confirm_password?.message && (
                  <span className="text-red-500">
                    {errors.confirm_password?.message}
                  </span>
                )
              }
              placeholder="••••••••"
              type="password"
            />
          </div>
          <div className="col-span-full">
            <div className="text-sm font-medium dark:text-white">
              Password requirements:
            </div>
            <div className="mb-1 text-sm font-normal text-gray-500 dark:text-gray-400">
              Ensure that these requirements are met:
            </div>
            <ul className="space-y-1 pl-4 text-gray-500 dark:text-gray-400">
              <li className="text-xs font-normal">
                At least 10 characters (and up to 100 characters)
              </li>
              <li className="text-xs font-normal">
                At least one lowercase character
              </li>
              <li className="text-xs font-normal">
                Inclusion of at least one special character, e.g., ! @ # ?
              </li>
            </ul>
          </div>
          <div className="col-span-6">
            <Button
              color="primary"
              type="submit"
              disabled={isSubmitting || !isDirty || !isValid}
            >
              Change Password
            </Button>
          </div>
        </div>
      </form>
    </Card>
  )
}

export default ChangePassword
