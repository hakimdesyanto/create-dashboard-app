---
to: src/packages/ui/json-edito/editor.tsx
---

import { HelperText } from 'flowbite-react'
import JSONEditor, { type JSONEditorOptions } from 'jsoneditor'
import 'jsoneditor/dist/jsoneditor.css'
import React, { useEffect, useRef, type FC } from 'react'
import { JsonEditorProps } from './types'

const JsonEditor: FC<JsonEditorProps> = function ({
  value,
  onChange,
  readOnly,
  helperText,
}) {
  const containerRef = useRef<HTMLDivElement>(null)
  const jsonEditorRef = useRef<JSONEditor | null>(null)

  useEffect(() => {
    if (containerRef.current) {
      const options: JSONEditorOptions = {
        mode: 'code',
        onChangeText: onChange,
        onEditable: () => !readOnly,
      }
      jsonEditorRef.current = new JSONEditor(containerRef.current, options)
      try {
        jsonEditorRef.current.set(value ? JSON.parse(value) : undefined)
      } catch (error) {
        jsonEditorRef.current.set(value)
      }
    }

    return () => {
      if (jsonEditorRef.current) {
        jsonEditorRef.current.destroy()
      }
    }
  }, [])

  return (
    <>
      <div className="h-80 w-full" ref={containerRef} />
      {helperText && (
        <HelperText className="text-red-500">{helperText}</HelperText>
      )}
    </>
  )
}

export default JsonEditor
