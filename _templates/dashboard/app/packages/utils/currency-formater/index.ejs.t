---
to: src/packages/utils/currency-formater/index.ts
---

export const currencyFormater = (value: number): any => {
  if (!value) {
    return '0'
  }

  if (typeof Intl !== 'undefined') {
    return Intl.NumberFormat('id-ID').format(value)
  }

  return value
    .toString()
    .replace(/^0+/, '')
    .replace(/\B(?=(\d{3})+(?!\d))/g, '.')
    .replace(/[A-Za-z]/g, '')
}
