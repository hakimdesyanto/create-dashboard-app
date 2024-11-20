---
to: src/app/(dashboard)/sidebar.tsx
---
'use client'

import { useLayoutContext } from '@/src/context/LayoutContext'
import { Sidebar } from 'flowbite-react'
import { useEffect, useState } from 'react'
import { HiFolder, HiFolderOpen, HiHome, HiUsers } from 'react-icons/hi'
import { twMerge } from 'tailwind-merge'
import contentMenus from './content-menus.json'

const menus: any = contentMenus

export function DashboardSidebar() {
  const {
    sidebar: { isSidebarCollapsed, setSidebarCollapsed },
  } = useLayoutContext()
  const [currentPage, setCurrentPage] = useState('')
  const [isPreview, setIsPreview] = useState(isSidebarCollapsed)

  const trailingSlash = (url: string) => {
    return url.replace(/\/?$/, '/')
  }

  const preview = {
    enable() {
      if (!isSidebarCollapsed) return

      setIsPreview(true)
      setSidebarCollapsed(false)
    },
    disable() {
      if (!isPreview) return

      setSidebarCollapsed(true)
    },
  }

  useEffect(() => {
    const newPage = trailingSlash(window.location.pathname)
    setCurrentPage(newPage)
  }, [window.location.pathname])

  useEffect(() => {
    if (isSidebarCollapsed) setIsPreview(false)
  }, [isSidebarCollapsed])

  return (
    <Sidebar
      onMouseEnter={preview.enable}
      onMouseLeave={preview.disable}
      aria-label="Sidebar with multi-level dropdown example"
      collapsed={isSidebarCollapsed}
      className={twMerge(
        'fixed inset-y-0 left-0 z-20 flex h-full shrink-0 flex-col border-r border-gray-200 pt-16 duration-75 lg:flex dark:border-gray-700',
        isSidebarCollapsed && 'hidden w-16',
      )}
      id="sidebar"
    >
      <div className="flex h-full flex-col justify-between">
        <div className="py-2">
          <Sidebar.Items>
            <Sidebar.ItemGroup className="mt-0 border-t-0 pb-1 pt-0">
              <Sidebar.Item
                href="/"
                icon={HiHome}
                className={
                  '/' === currentPage ? 'bg-gray-100 dark:bg-gray-700' : ''
                }
              >
                Home
              </Sidebar.Item>
              <Sidebar.Collapse
                icon={HiUsers}
                label="Administrators"
                open={currentPage.startsWith('/admin/')}
              >
                <Sidebar.Item
                  href="/admin/user"
                  className={
                    currentPage.startsWith('/admin/user/') ? 'bg-gray-100 dark:bg-gray-700' : ''
                  }
                >
                  Users
                </Sidebar.Item>
                <Sidebar.Item
                  href="/admin/role"
                  className={
                    currentPage.startsWith('/admin/role/') ? 'bg-gray-100 dark:bg-gray-700' : ''
                  }
                >
                  Roles
                </Sidebar.Item>
              </Sidebar.Collapse>
            </Sidebar.ItemGroup>
            {menus.length > 0 &&
              <Sidebar.ItemGroup className="mt-2 pt-2">
                {menus.map((menu: any) => {
                  if (menu.submenus) {
                    const isFolderOpen = menu.submenus.some((submenu: any) => currentPage.startsWith(trailingSlash(submenu.href)))
                    return (
                      <Sidebar.Collapse
                        key={menu.name}
                        icon={isFolderOpen ? HiFolderOpen : HiFolder}
                        label={menu.label}
                        open={isFolderOpen}
                      >
                        {menu.submenus.map((submenu: any) => (
                          <Sidebar.Item
                            key={submenu.name}
                            href={submenu.href}
                            className={
                              currentPage.startsWith(trailingSlash(submenu.href))
                                ? 'bg-gray-100 dark:bg-gray-700'
                                : ''
                            }
                          >
                            {submenu.label}
                          </Sidebar.Item>
                        ))}
                      </Sidebar.Collapse>
                    )
                  } else {
                    const isFolderOpen = currentPage.startsWith(trailingSlash(menu.href))
                    return (
                      <Sidebar.Item
                        key={menu.name}
                        href={menu.href}
                        icon={isFolderOpen ? HiFolderOpen : HiFolder}
                        className={
                          isFolderOpen ? 'bg-gray-100 dark:bg-gray-700' : ''
                        }
                      >
                        {menu.label}
                      </Sidebar.Item>
                    )
                  }
                })}
              </Sidebar.ItemGroup>
            }
          </Sidebar.Items>
        </div>
      </div>
    </Sidebar>
  )
}
