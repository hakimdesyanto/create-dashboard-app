---
to: src/app/(dashboard)/navbar.tsx
---
'use client'

import { useAuth } from '@/src/context/AuthContext'
import { useLayoutContext } from '@/src/context/LayoutContext'
import { isSmallScreen } from '@/src/packages/utils/is-small-screen'
import {
  Avatar,
  Button,
  DarkThemeToggle,
  Dropdown,
  Modal,
  Navbar,
  Tooltip,
  useThemeMode,
} from 'flowbite-react'
import Image from 'next/image'
import { useState } from 'react'
import { HiMenuAlt1, HiOutlineExclamationCircle, HiX } from 'react-icons/hi'

export function DashboardNavbar() {
  const {
    sidebar: { isSidebarCollapsed, setSidebarCollapsed },
  } = useLayoutContext()
  const { computedMode } = useThemeMode()

  return (
    <Navbar
      fluid
      className="fixed top-0 z-30 w-full border-b border-gray-200 bg-white p-0 sm:p-0 dark:border-gray-700 dark:bg-gray-800"
    >
      <div className="w-full p-3 pr-4">
        <div className="flex items-center justify-between">
          <div className="flex items-center">
            <button
              onClick={() => setSidebarCollapsed(!isSidebarCollapsed)}
              className="mr-3 cursor-pointer rounded p-2 text-gray-600 hover:bg-gray-100 hover:text-gray-900 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
            >
              <span className="sr-only">Toggle sidebar</span>
              {isSidebarCollapsed || !isSmallScreen() ? (
                <HiMenuAlt1 className="h-6 w-6" />
              ) : (
                <HiX className="h-6 w-6" />
              )}
            </button>
            <Navbar.Brand href="/" className="mr-14">
              <Image
                alt="logo"
                src="/images/logo.svg"
                className="mr-3 h-8"
                width={32}
                height={32}
                priority
              />
              <span className="hidden self-center whitespace-nowrap text-2xl font-semibold lg:block dark:text-white">
                <%=h.changeCase.titleCase(name)%> Dashboard
              </span>
            </Navbar.Brand>
          </div>
          <div className="flex items-center gap-3">
            <div className="flex items-center">
              <Tooltip
                content={
                  computedMode === 'light'
                    ? 'Toggle dark mode'
                    : 'Toggle light mode'
                }
              >
                <DarkThemeToggle />
              </Tooltip>
            </div>
            <div className="block">
              <UserDropdown />
            </div>
          </div>
        </div>
      </div>
    </Navbar>
  )
}

function UserDropdown() {
  const [openModal, setOpenModal] = useState(false)

  return (
    <>
      <Dropdown
        className="rounded"
        arrowIcon={false}
        inline
        label={
          <span>
            <span className="sr-only">User menu</span>
            <Avatar
              alt="avatar"
              img="/images/icons/icon_anonymous-user.png"
              rounded
              size="sm"
            />
          </span>
        }
      >
        <Dropdown.Item href="/account/setting">Settings</Dropdown.Item>
        <Dropdown.Item
          onClick={() => {
            setOpenModal(true)
          }}
        >
          Sign out
        </Dropdown.Item>
      </Dropdown>
      <LogoutModal openModal={openModal} setOpenModal={setOpenModal} />
    </>
  )
}

function LogoutModal({ openModal, setOpenModal }: any) {
  const { logout } = useAuth()

  return (
    <Modal
      show={openModal}
      size="md"
      onClose={() => setOpenModal(false)}
      dismissible
      popup
    >
      <Modal.Header />
      <Modal.Body>
        <div className="text-center">
          <HiOutlineExclamationCircle className="mx-auto mb-4 h-14 w-14 text-gray-400 dark:text-gray-200" />
          <h3 className="mb-5 text-lg font-normal text-gray-500 dark:text-gray-400">
            Are you sure you want to logout?
          </h3>
          <div className="flex justify-center gap-4">
            <Button color="primary" onClick={() => logout() }>
              {"Yes, I'm sure"}
            </Button>
            <Button color="gray" onClick={() => setOpenModal(false)}>
              No, cancel
            </Button>
          </div>
        </div>
      </Modal.Body>
    </Modal>
  )
}
