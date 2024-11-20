---
to: src/packages/ui/file-input/index.tsx
---

import {
  FileInput as FlowbiteFileInput,
  HelperText,
  Label,
  Spinner,
} from 'flowbite-react'
import Image from 'next/image'
import React, { useEffect, useState, type FC } from 'react'
import { IoClose, IoCloudUploadOutline } from 'react-icons/io5'

const FileInput: FC<any> = function ({
  id,
  name,
  value,
  allowDelete,
  onDelete,
  onChange,
  helperText,
  isProcessingUpload,
  accept = 'image/jpeg, image/png',
  title = 'JPG or PNG (Max. 500kb)',
  ...props
}) {
  const [imageLoaded, setImageLoaded] = useState(false)

  useEffect(() => {
    if (isProcessingUpload) {
      setImageLoaded(false)
    }
  }, [isProcessingUpload])

  return (
    <div className="w-full max-w-[400px]">
      <div className="flex w-full flex-col items-center justify-center gap-4 rounded-lg border-2 border-dashed border-gray-300 bg-gray-50 p-4 hover:bg-gray-100 dark:border-gray-600 dark:bg-gray-700 dark:hover:border-gray-500 dark:hover:bg-gray-600">
        {value && (
          <div className="relative">
            <Image
              src={value}
              alt="image preview"
              width={640}
              height={460}
              className="h-auto max-h-60 w-auto rounded-lg"
              onLoadingComplete={() => setImageLoaded(true)}
            />
            {allowDelete && imageLoaded && (
              <button
                type="button"
                className="bg-primary-700 dark:bg-primary-600 absolute right-0 top-0 rounded-bl-lg rounded-tr-lg p-1"
                onClick={() => onDelete()}
              >
                <IoClose className="text-white" />
              </button>
            )}
          </div>
        )}
        <Label
          htmlFor={!isProcessingUpload ? id : undefined}
          className={`${
            isProcessingUpload ? 'cursor-progress' : 'cursor-pointer'
          } flex w-full flex-col items-center justify-center rounded-lg border-2 border-dashed border-gray-300 p-5 dark:border-gray-500`}
        >
          {!isProcessingUpload ? (
            <IoCloudUploadOutline className="mb-4 h-8 w-8 text-gray-500 dark:text-gray-400" />
          ) : (
            <Spinner className="mb-4 h-8 w-8" />
          )}
          <p className="mb-2 text-center text-sm text-gray-500 dark:text-gray-400">
            <span className="font-semibold">Click to upload</span>
          </p>
          <p className="text-center text-xs text-gray-500 dark:text-gray-400">
            {title}
          </p>
        </Label>
        <FlowbiteFileInput
          id={id}
          accept={accept}
          onChange={onChange}
          className="hidden"
          {...props}
        />
      </div>
      {helperText && (
        <HelperText className="text-red-500">{helperText}</HelperText>
      )}
    </div>
  )
}

export default FileInput
