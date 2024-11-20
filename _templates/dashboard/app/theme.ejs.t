---
to: src/app/theme.ts
---
import { theme, type CustomFlowbiteTheme } from 'flowbite-react'
import { twMerge } from 'tailwind-merge'

export const customTheme: CustomFlowbiteTheme = {
  checkbox: {
    root: {
      color: {
        default:
          'text-primary-500 border-gray-300 bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:focus:ring-primary-600 dark:ring-offset-gray-800 dark:bg-gray-700 dark:border-gray-600',
      },
    },
  },
  modal: {
    content: {
      inner: twMerge(theme.modal.content.inner, 'dark:bg-gray-800'),
    },
    header: {
      base: twMerge(
        theme.modal.header.base,
        'items-center dark:border-gray-700',
      ),
      title: twMerge(theme.modal.header.title, 'font-semibold'),
      close: {
        base: twMerge(
          theme.modal.header.close.base,
          'hover:bg-gray-200 dark:hover:bg-gray-700',
        ),
      },
    },
    footer: {
      base: twMerge(theme.modal.footer.base, 'dark:border-gray-700'),
    },
  },
  progress: {
    color: {
      primary: 'bg-primary-600',
      dark: 'bg-gray-900 dark:bg-white',
    },
    size: {
      md: 'h-2',
    },
  },
  select: {
    field: {
      select: {
        sizes: {
          md: twMerge(
            theme.select.field.select.sizes.md,
            'text-base sm:text-sm',
          ),
        },
        colors: {
          gray: twMerge(
            theme.select.field.select.colors.gray,
            'focus:border-primary-500 focus:ring-primary-500 dark:focus:border-primary-500 dark:focus:ring-primary-500',
          ),
        },
      },
    },
  },
  sidebar: {
    root: {
      inner: twMerge(theme.sidebar.root.inner, 'bg-white'),
    },
    collapse: {
      button: twMerge(
        theme.sidebar.collapse.button,
        'text-gray-900 hover:bg-gray-100 dark:text-gray-200 dark:hover:bg-gray-700',
      ),
    },
    item: {
      base: twMerge(
        theme.sidebar.collapse.button,
        'text-gray-900 hover:bg-gray-100 dark:text-gray-200 dark:hover:bg-gray-700',
      ),
      label:
        'inline-flex justify-center items-center p-1 ml-3 w-5 h-5 text-sm font-medium rounded-full text-primary-800 bg-primary-100',
    },
  },
  textarea: {
    base: twMerge(theme.textarea.base, 'p-4'),
    colors: {
      primary: twMerge(
        theme.textarea.colors.gray,
        'text-base focus:border-primary-500 focus:ring-primary-500 dark:focus:border-primary-500 dark:focus:ring-primary-500 sm:text-sm',
      ),
    },
  },
  textInput: {
    field: {
      input: {
        colors: {
          primary: 'bg-gray-50 border-gray-300 text-gray-900 focus:border-primary-500 focus:ring-primary-500 focus:outline-primary-500 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400 dark:focus:border-primary-500 dark:focus:ring-primary-500 dark:focus:outline-primary-500',
        },
        sizes: {
          md: 'sm:text-sm p-2.5',
        },
      },
    },
  },
  toggleSwitch: {
    toggle: {
      base: 'toggle-bg rounded-full border',
      checked: {
        color: {
          primary: 'bg-primary-600 border-primary-600',
        },
      },
    },
  },
  card: {
    root: {
      base: twMerge(theme.card.root.base, 'border-none shadow'),
      children: 'p-4 sm:p-6 xl:p-8',
    },
  },
  button: {
    color: {
      primary: 'text-white bg-primary-700 border border-transparent enabled:hover:bg-primary-800 focus:ring-4 focus:ring-primary-300 dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800',
    },
  },
  badge: {
    root: {
      color: {
        primary: 'bg-primary-100 text-primary-800 dark:bg-primary-200 dark:text-primary-900 group-hover:bg-primary-200 dark:group-hover:bg-primary-300',
      },
    },
  },
  radio: {
    root: {
      base: 'h-4 w-4 border border-gray-300 focus:ring-2 focus:ring-primary-500 dark:border-gray-600 dark:bg-gray-700 dark:focus:bg-primary-600 dark:focus:ring-primary-600 text-primary-600'
    },
  },
  datepicker: {
    popup: {
      footer: {
        button: {
          base: 'w-full rounded-lg px-5 py-2 text-center text-sm font-medium focus:ring-4 focus:ring-primary-300',
          today: 'bg-primary-700 text-white hover:bg-primary-800 dark:bg-primary-600 dark:hover:bg-primary-700',
        }
      }
    },
    views: {
      days: {
        items: {
          item: {
            selected: 'bg-primary-700 text-white hover:bg-primary-600',
          }
        }
      },
      months: {
        items: {
          item: {
            selected: 'bg-primary-700 text-white hover:bg-primary-600',
          }
        }
      },
      years: {
        items: {
          item: {
            selected: 'bg-primary-700 text-white hover:bg-primary-600',
          }
        }
      },
      decades: {
        items: {
          item: {
            selected: 'bg-primary-700 text-white hover:bg-primary-600',
          }
        }
      }
    }
  },
}
