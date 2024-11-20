---
to: src/context/LayoutContext.tsx
---
'use client'

import { isBrowser } from '@/src/packages/utils/is-browser'
import { isSmallScreen } from '@/src/packages/utils/is-small-screen'
import type { PropsWithChildren } from 'react'
import { createContext, useContext, useEffect, useState } from 'react'

interface SidebarContextProps {
  isSidebarCollapsed: boolean
  setSidebarCollapsed: (isOpen: boolean) => void
}

interface ToastContextProps {
  toast: {
    message: string
    color?: 'default' | 'success' | 'failure' | 'warning'
    show: boolean
  }
  setToast: (props: {
    message: string
    color?: 'default' | 'success' | 'failure' | 'warning'
    show: boolean
  }) => void
}

interface LayoutContextProps {
  sidebar: SidebarContextProps
  toast: ToastContextProps
}

const LayoutContext = createContext<LayoutContextProps | null>(null)

export function LayoutProvider({ children }: PropsWithChildren) {
  const location = isBrowser() ? window.location.pathname : '/'
  const storedIsSidebarCollapsed = isBrowser()
    ? localStorage.getItem('isSidebarCollapsed') === 'true'
    : false

  const [isSidebarCollapsed, setSidebarCollapsed] = useState(
    storedIsSidebarCollapsed,
  )
  const [toast, setToast] = useState<ToastContextProps['toast']>({
    message: '',
    show: false,
  })

  // Close Sidebar on page change on mobile
  useEffect(() => {
    if (isSmallScreen()) {
      setSidebarCollapsed(true)
    }
  }, [location])

  // Close Sidebar on mobile tap inside main content
  useEffect(() => {
    function handleMobileTapInsideMain(event: MouseEvent) {
      const main = document.querySelector('#main-content')
      const isClickInsideMain = main?.contains(event.target as Node)

      if (isSmallScreen() && isClickInsideMain) {
        setSidebarCollapsed(true)
      }
    }

    document.addEventListener('mousedown', handleMobileTapInsideMain)

    return () => {
      document.removeEventListener('mousedown', handleMobileTapInsideMain)
    }
  }, [])

  // Update local storage when collapsed state changed
  useEffect(() => {
    localStorage.setItem(
      'isSidebarCollapsed',
      isSidebarCollapsed ? 'true' : 'false',
    )
  }, [isSidebarCollapsed])

  return (
    <LayoutContext.Provider
      value={{
        sidebar: {
          isSidebarCollapsed,
          setSidebarCollapsed,
        },
        toast: {
          toast,
          setToast,
        },
      }}
    >
      {children}
    </LayoutContext.Provider>
  )
}

export function useLayoutContext(): LayoutContextProps {
  const context = useContext(LayoutContext)

  if (!context) {
    throw new Error(
      'useSidebarContext should be used within the SidebarContext provider!',
    )
  }

  return context
}
