---
to: src/packages/ui/toast/index.tsx
---

import { Toast as FlowbiteToast } from 'flowbite-react'
import React, { type FC } from 'react'
import {
  HiCheck,
  HiExclamation,
  HiInformationCircle,
  HiX,
} from 'react-icons/hi'

interface ToastProps {
  show: boolean
  message: string
  color?: 'default' | 'success' | 'failure' | 'warning'
  onDismiss: () => void
}

const Toast: FC<ToastProps> = function ({
  show,
  message,
  color = 'default',
  onDismiss,
}) {
  return (
    <>
      {show && (
        <FlowbiteToast className="fixed inset-x-0 top-20 z-10 mx-auto">
          {color === 'success' && (
            <div className="inline-flex h-8 w-8 shrink-0 items-center justify-center rounded-lg bg-green-100 text-green-500 dark:bg-green-800 dark:text-green-200">
              <HiCheck className="h-5 w-5" />
            </div>
          )}
          {color === 'failure' && (
            <div className="inline-flex h-8 w-8 shrink-0 items-center justify-center rounded-lg bg-red-100 text-red-500 dark:bg-red-800 dark:text-red-200">
              <HiX className="h-5 w-5" />
            </div>
          )}
          {color === 'warning' && (
            <div className="inline-flex h-8 w-8 shrink-0 items-center justify-center rounded-lg bg-orange-100 text-orange-500 dark:bg-orange-700 dark:text-orange-200">
              <HiExclamation className="h-5 w-5" />
            </div>
          )}
          {color === 'default' && (
            <div className="inline-flex h-8 w-8 shrink-0 items-center justify-center rounded-lg bg-blue-100 text-blue-500 dark:bg-blue-700 dark:text-blue-200">
              <HiInformationCircle className="h-5 w-5" />
            </div>
          )}
          <div className="ml-3 text-sm font-normal">{message}</div>
          <FlowbiteToast.Toggle onDismiss={onDismiss} />
        </FlowbiteToast>
      )}
    </>
  )
}

export default Toast
