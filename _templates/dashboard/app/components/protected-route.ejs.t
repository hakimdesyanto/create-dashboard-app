---
to: src/components/protected-route.tsx
---
import { useAuth } from '@/src/context/AuthContext'
import { useRouter, usePathname, useSearchParams } from 'next/navigation'
import type { PropsWithChildren } from 'react'

type ProtectedRouteProps = {
  children: React.ReactNode
}

const ProtectedRoute: React.FC<ProtectedRouteProps> = ({
  children,
}: PropsWithChildren) => {
  const router = useRouter()
  const pathname = usePathname()
  const searchParams = useSearchParams()
  const { userToken } = useAuth()

  if (typeof userToken !== 'undefined' && !userToken) {
    const params = searchParams.toString() ? `?${searchParams.toString()}` : ''
    router.push(`/auth/sign-in?ref=${pathname}${params}`)
  }

  return <>{userToken && children}</>
}

export default ProtectedRoute
