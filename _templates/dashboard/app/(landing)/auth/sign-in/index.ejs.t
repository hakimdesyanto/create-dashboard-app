---
to: src/app/(landing)/auth/sign-in/index.tsx
---
'use client'

import { useAuth } from '@/src/context/AuthContext'
import { loginAccount } from '@/src/services/base/account'
import Toast from '@/src/packages/ui/toast'
import { zodResolver } from '@hookform/resolvers/zod'
import { Button, Card, Label, TextInput } from 'flowbite-react'
import Image from 'next/image'
import Link from 'next/link'
import { useRouter, useSearchParams } from 'next/navigation'
import { useEffect, useState, type FC } from 'react'
import { useForm } from 'react-hook-form'
import * as z from 'zod'

interface ToastProps {
  show: boolean
  message: string
  color?: 'default' | 'success' | 'failure' | 'warning'
}

const signInSchema = z.object({
  email: z
    .string()
    .min(1, { message: 'Email is required' })
    .email('Email is not valid'),
  password: z.string().min(1, { message: 'Password is required' }),
})

type SignInSchema = z.infer<typeof signInSchema>

const SignIn: FC = function () {
  const router = useRouter()
  const searchParams = useSearchParams()
  const [toast, setToast] = useState<ToastProps>({
    message: '',
    show: false,
  })
  const { userToken, login } = useAuth()
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting, isDirty, isValid },
  } = useForm<SignInSchema>({
    resolver: zodResolver(signInSchema),
    mode: 'onChange',
  })

  useEffect(() => {
    if (toast.show) {
      const autoCloseToast = setTimeout(() => {
        setToast({
          message: '',
          show: false,
        })
      }, 2000)
      return () => clearTimeout(autoCloseToast)
    }
  }, [toast.show])

  const fetchLoginAccount = async (data: any): Promise<any> => {
    try {
      const response = await loginAccount(data)
      if (response.status === 200) {
        const { token, refresh_token } = response.data.data[0]
        login(token, refresh_token)
        const ref = searchParams.get('ref') || '/'
        router.push(ref)
      } else {
        setToast({
          message: 'Login failed',
          color: 'failure',
          show: true,
        })
      }
    } catch (error: any) {
      throw new Error(error)
    }
  }

  const onSubmit = async (data: SignInSchema) => {
    console.log(data)
    fetchLoginAccount(data)
  }

  if (typeof userToken !== 'undefined' && !!userToken && !isValid) {
    router.push('/')
  }

  return (
    <div className="mx-auto flex flex-col items-center justify-center px-6 pt-8 md:h-screen">
      <Toast
        show={toast.show}
        message={toast.message}
        color={toast.color}
        onDismiss={() => {
          setToast({
            message: '',
            show: false,
          })
        }}
      />
      <Link
        href="/"
        className="mb-8 flex items-center justify-center text-2xl font-semibold lg:mb-10 dark:text-white"
      >
        <Image
          alt="logo"
          src="/images/logo.svg"
          width={43}
          height={44}
          className="mr-4 h-11"
        />
        <span className="self-center whitespace-nowrap text-2xl font-semibold dark:text-white">
          <%=h.changeCase.titleCase(appName)%> Dashboard
        </span>
      </Link>
      <Card
        horizontal
        imgAlt="login"
        imgSrc="/images/authentication/login.jpg"
        className="w-full md:max-w-[1024px]"
        theme={{
          root: {
            children: 'my-auto w-full gap-0 space-y-8 p-6 sm:p-8 lg:p-16',
          },
          img: {
            horizontal: {
              on: 'hidden rounded-l-lg md:w-96 md:p-0 lg:block w-2/3',
            },
          },
        }}
      >
        <h2 className="text-2xl font-bold text-gray-900 lg:text-3xl dark:text-white">
          Sign in
        </h2>
        <form className="mt-8 space-y-6" onSubmit={handleSubmit(onSubmit)}>
          <div className="flex flex-col gap-y-2">
            <Label htmlFor="email">Your email</Label>
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
          <div className="flex flex-col gap-y-2">
            <Label htmlFor="password">Your password</Label>
            <TextInput
              {...register('password')}
              id="password"
              color="primary"
              helperText={
                errors.password?.message && (
                  <span className="text-red-500">
                    {errors.password?.message}
                  </span>
                )
              }
              type="password"
            />
          </div>
          <div className="mb-6">
            <Button
              size="lg"
              color="primary"
              type="submit"
              theme={{ inner: { base: 'px-5 py-3' } }}
              className="w-full px-0 py-[1px] sm:w-auto"
              disabled={isSubmitting || !isDirty || !isValid}
              isProcessing={isSubmitting}
            >
              Login
            </Button>
          </div>
        </form>
      </Card>
    </div>
  )
}

export default SignIn
