---
to: src/packages/ui/rich-text-editor/index.tsx
---

import { HelperText } from 'flowbite-react'
import dynamic from 'next/dynamic'
import React, { useMemo, type FC } from 'react'
import 'react-quill/dist/quill.snow.css'

const RichTextEditor: FC<any> = function ({
  value,
  onChange,
  helperText,
  ...props
}) {
  const ReactQuill = useMemo(
    () => dynamic(() => import('react-quill'), { ssr: false }),
    [],
  )
  const modules = {
    toolbar: [
      [{ header: [1, 2, false] }],
      ['bold', 'italic', 'underline', 'strike', 'blockquote'],
      [
        { list: 'ordered' },
        { list: 'bullet' },
        { indent: '-1' },
        { indent: '+1' },
      ],
      ['link', 'image'],
      ['clean'],
    ],
  }
  const formats = [
    'header',
    'bold',
    'italic',
    'underline',
    'strike',
    'blockquote',
    'list',
    'bullet',
    'indent',
    'link',
    'image',
  ]

  return (
    <>
      <ReactQuill
        theme="snow"
        value={value}
        onChange={onChange}
        modules={modules}
        formats={formats}
        {...props}
      />
      {helperText && (
        <HelperText className="text-red-500">{helperText}</HelperText>
      )}
    </>
  )
}

export default RichTextEditor
