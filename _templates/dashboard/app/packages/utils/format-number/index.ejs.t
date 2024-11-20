---
to: src/packages/utils/format-number/index.ts
---

export const formatNumber = (value: number): string => {
  return value.toLocaleString('id-ID')
}

export const formatToIDR = (value: number): string => {
  return value.toLocaleString('id-ID', {
    style: 'currency',
    currency: 'IDR',
    maximumFractionDigits: 0,
  })
}
