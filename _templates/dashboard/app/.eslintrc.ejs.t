---
to: .eslintrc.json
force: true
---
{
  "extends": "../../.eslintrc.json",
  "rules": {
    "tailwindcss/classnames-order": [
      "warn",
      {
        "callees": ["classnames"],
        "config": "tailwind.config.ts"
      }
    ],
    "tailwindcss/no-custom-classname": [
      "warn",
      {
        "config": "tailwind.config.ts"
      }
    ]
  }
}
