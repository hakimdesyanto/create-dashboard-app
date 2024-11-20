---
to: src/context/AuthContext.tsx
---
'use client'

import { useRouter } from 'next/navigation'
import {
  ReactNode,
  createContext,
  useContext,
  useEffect,
  useState,
  type PropsWithChildren,
} from 'react'
import Cookies from 'universal-cookie'

type AuthContextType = {
  userToken?: string
  login: (token: string, refresh_token: string) => void
  logout: () => void
}

const AuthContext = createContext<AuthContextType | undefined>(undefined)
const cookies = new Cookies()

type AuthProviderProps = {
  children: ReactNode
}

export const AuthProvider: React.FC<AuthProviderProps> = ({
  children,
}: PropsWithChildren) => {
  const router = useRouter()
  const [userToken, setUserToken] = useState<string | undefined>(undefined)
  const userTokenCookie = cookies.get('user_token') || ''

  useEffect(() => {
    setUserToken(userTokenCookie)
  }, [userTokenCookie])

  const login = (token: string, refresh_token: string) => {
    setUserToken(token)
    cookies.set('user_token', token, {
      path: '/',
      expires: new Date(new Date().setHours(new Date().getHours() + 2)),
    })
    cookies.set('refresh_token', refresh_token, {
      path: '/',
      expires: new Date(new Date().setDate(new Date().getDate() + 2)),
    })
  }

  const logout = () => {
    setUserToken('')
    cookies.remove('user_token', {
      path: '/',
    })
    cookies.remove('refresh_token', {
      path: '/',
    })
    router.push('/auth/sign-in')
  }

  return (
    <AuthContext.Provider value={{ userToken, login, logout }}>
      {children}
    </AuthContext.Provider>
  )
}

export const useAuth = () => {
  const context = useContext(AuthContext)
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider')
  }
  return context
}
