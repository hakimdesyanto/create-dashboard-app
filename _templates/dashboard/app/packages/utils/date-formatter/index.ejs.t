---
to: src/packages/utils/date-formatter/index.ts
---

import dayjs from 'dayjs'

export const dateFormatter = (date: string, format: string): any => {
  if (date === null || date === undefined || date === '0001-01-01T00:00:00Z') {
    return '-'
  } else {
    return dayjs(date).format(format)
  }
}
