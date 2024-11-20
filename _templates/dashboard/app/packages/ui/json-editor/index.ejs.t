---
to: src/packages/ui/json-edito/index.tsx
---

import dynamic from 'next/dynamic'
import React, { useMemo, type FC } from 'react'
import { JsonEditorProps } from './types'

const DynamicJsonEditor: FC<JsonEditorProps> = function ({
  value,
  onChange,
  readOnly,
  helperText,
  ...props
}) {
  const JsonEditor = useMemo(
    () => dynamic(() => import('./editor'), { ssr: false }),
    [],
  )

  return (
    <JsonEditor
      value={value}
      onChange={onChange}
      readOnly={readOnly}
      helperText={helperText}
      {...props}
    />
  )
}

export default DynamicJsonEditor
