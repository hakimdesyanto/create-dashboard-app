---
to: tsconfig.json
force: true
---

{
  "compilerOptions": {
    "allowJs": true,
    "esModuleInterop": true,
    "incremental": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "lib": ["dom", "dom.iterable", "esnext"],
    "module": "esnext",
    "moduleResolution": "bundler",
    "noEmit": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["./*"]
    },
    "plugins": [
      {
        "name": "next"
      }
    ],
    "resolveJsonModule": true,
    "skipLibCheck": true,
    "strict": true,
    "target": "es5"
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules", "dangerfile.ts"]
}

