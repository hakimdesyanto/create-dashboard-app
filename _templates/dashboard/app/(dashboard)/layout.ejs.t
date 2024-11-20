---
to: src/app/(dashboard)/layout.tsx
---
'use client'

import ProtectedRoute from '@/src/components/protected-route'
import { LayoutProvider, useLayoutContext } from '@/src/context/LayoutContext'
import Toast from '@/src/packages/ui/toast'
import { useEffect, type PropsWithChildren } from 'react'
import { twMerge } from 'tailwind-merge'
import { DashboardNavbar } from './navbar'
import { DashboardSidebar } from './sidebar'

export default function DashboardLayout({ children }: PropsWithChildren) {
  return (
    <ProtectedRoute>
      <LayoutProvider>
        <Content>{children}</Content>
      </LayoutProvider>
    </ProtectedRoute>
  )
}

function Content({ children }: PropsWithChildren) {
  const {
    sidebar: { isSidebarCollapsed },
    toast: { toast, setToast },
  } = useLayoutContext()

  useEffect(() => {
    if (toast.show) {
      const autoCloseToast = setTimeout(() => {
        setToast({
          message: '',
          show: false,
        })
      }, 5000)
      return () => clearTimeout(autoCloseToast)
    }
  }, [toast.show])

  return (
    <>
      <DashboardNavbar />
      <div className="mt-16 flex items-start">
        <DashboardSidebar />
        <div
          id="main-content"
          className={twMerge(
            'relative h-full w-full bg-gray-50 dark:bg-gray-900',
            isSidebarCollapsed
              ? 'lg:ml-16 lg:w-[calc(100%-64px)]'
              : 'lg:ml-64 lg:w-[calc(100%-256px)]',
          )}
        >
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
          {children}
        </div>
      </div>
    </>
  )
}
