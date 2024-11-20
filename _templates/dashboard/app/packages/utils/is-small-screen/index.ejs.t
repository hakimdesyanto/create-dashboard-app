---
to: src/packages/utils/is-small-screen/index.ts
---

import { isBrowser } from '@/src/packages/utils/is-browser'

export const isSmallScreen = (): boolean => {
  return isBrowser() && window.innerWidth < 768
}
