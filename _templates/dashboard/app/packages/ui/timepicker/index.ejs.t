---
to: src/packages/ui/timepicker/index.tsx
---

import { HelperText } from 'flowbite-react'
import React, { useRef, type FC } from 'react'
import './style.css'

interface Props {
  value?: Date | string | any
  onChange?: (v: any) => void
  showHelperText?: boolean
  helperText?: React.ReactNode
  showInput?: boolean
  disabled?: boolean
}

const Timepicker: FC<Props> = function ({
  value,
  onChange = (_: any) => {},
  showHelperText = true,
  helperText,
  showInput = true,
  disabled = false,
}) {
  const timeRef = useRef(null)

  const onShowPicker = () => {
    if (disabled) return
    ;(timeRef.current as any).showPicker()
  }

  const TimePickerWithInput: React.FC = () => (
    <>
      <div className="relative">
        <div
          tabIndex={0}
          role="button"
          className="absolute inset-y-0 end-0 top-0 flex flex h-9 w-8 items-center items-center justify-center"
          onClick={onShowPicker}
          onKeyDown={onShowPicker}
        >
          <svg
            className="h-4 w-4 text-gray-500 dark:text-gray-400"
            aria-hidden="true"
            xmlns="http://www.w3.org/2000/svg"
            fill="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              fillRule="evenodd"
              d="M2 12C2 6.477 6.477 2 12 2s10 4.477 10 10-4.477 10-10 10S2 17.523 2 12Zm11-4a1 1 0 1 0-2 0v4a1 1 0 0 0 .293.707l3 3a1 1 0 0 0 1.414-1.414L13 11.586V8Z"
              clipRule="evenodd"
            />
          </svg>
        </div>
        <input
          ref={timeRef}
          type="time"
          className="timepicker-input block w-full rounded-lg border border-gray-300 bg-gray-50 p-2.5 text-sm leading-none text-gray-900 focus:border-blue-500 focus:ring-blue-500 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400 dark:focus:border-blue-500 dark:focus:ring-blue-500"
          value={value || '00:00'}
          onChange={(e) => onChange(e.target.value)}
          disabled={disabled}
        />
      </div>
      {showHelperText && helperText && (
        <HelperText className="text-red-500">{helperText}</HelperText>
      )}
    </>
  )

  const TimeComponent: React.FC = () => (
    <>
      <div
        tabIndex={0}
        role="button"
        className="absolute right-0 top-0 mt-0.5 flex h-10 w-8 cursor-pointer items-center justify-center"
        onClick={onShowPicker}
        onKeyDown={onShowPicker}
      >
        <div className="absolute text-center">
          <svg
            className="h-4 w-4 text-gray-500 dark:text-gray-400"
            aria-hidden="true"
            xmlns="http://www.w3.org/2000/svg"
            fill="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              fillRule="evenodd"
              d="M2 12C2 6.477 6.477 2 12 2s10 4.477 10 10-4.477 10-10 10S2 17.523 2 12Zm11-4a1 1 0 1 0-2 0v4a1 1 0 0 0 .293.707l3 3a1 1 0 0 0 1.414-1.414L13 11.586V8Z"
              clipRule="evenodd"
            />
          </svg>
        </div>
        <input
          ref={timeRef}
          type="time"
          className="timepicker-input h-1 border-none bg-transparent focus:outline-none"
          value={value || '00:00'}
          onChange={(e) => onChange(e.target.value)}
          disabled={disabled}
        />
      </div>
      {showHelperText && helperText && (
        <HelperText className="text-red-500">{helperText}</HelperText>
      )}
    </>
  )

  if (showInput) return <TimePickerWithInput />

  return <TimeComponent />
}

export default Timepicker
