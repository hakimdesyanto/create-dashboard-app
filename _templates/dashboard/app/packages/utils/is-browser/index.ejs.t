---
to: src/packages/utils/is-browser/index.ts
---

export const isBrowser = (): boolean => {
  return typeof window !== 'undefined'
}
