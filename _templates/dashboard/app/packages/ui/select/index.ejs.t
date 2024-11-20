---
to: src/packages/ui/select/index.tsx
---

import { HelperText } from 'flowbite-react'
import React, { type FC } from 'react'
import ReactTailwindCSSSelect from 'react-tailwindcss-select'

const Select: FC<any> = function ({ helperText, ...props }) {
  return (
    <>
      <ReactTailwindCSSSelect
        isSearchable
        isClearable
        classNames={{
          menuButton: (value: any) => {
            const className =
              'flex w-full border disabled:cursor-not-allowed disabled:opacity-50 p-0.5 bg-gray-50 border-gray-300 text-gray-900 focus:border-primary-500 focus:ring-primary-500 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400 dark:focus:border-primary-500 dark:focus:ring-primary-500 sm:text-sm rounded-lg'
            return value?.isDisabled
              ? `${className} cursor-not-allowed opacity-50`
              : className
          },
          menu: 'absolute z-10 w-full bg-white dark:bg-gray-800 shadow-lg border border-gray-300 dark:border-gray-700 rounded-lg py-1 mt-1.5 text-sm text-gray-700 dark:text-white',
          searchBox:
            'w-full py-2 pl-8 text-sm text-gray-500 bg-gray-100 border border-gray-200 rounded-lg focus:border-gray-200 focus:ring-0 focus:outline-none dark:focus:border-primary-500 dark:border-gray-600 dark:bg-gray-700 dark:text-white',
          listItem: (value: any) => {
            return value?.isSelected
              ? 'block transition duration-200 px-2 py-2 cursor-pointer select-none truncate rounded-lg mb-1 text-white bg-primary-500'
              : 'block transition duration-200 px-2 py-2 cursor-pointer select-none truncate rounded-lg mb-1 text-gray-500 hover:bg-primary-100 hover:text-primary-500 dark:text-white dark:hover:bg-primary-200'
          },
        }}
        {...props}
      />
      {helperText && (
        <HelperText className="text-red-500">{helperText}</HelperText>
      )}
    </>
  )
}

export default Select
