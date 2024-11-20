---
to: src/packages/ui/json-edito/types.ts
---

export interface JsonEditorProps {
  value: string
  onChange: (text: string) => void
  readOnly?: boolean
  helperText?: React.ReactNode
}
