---
to: package.json
force: true
---

{
  "name": "<%=appName%>",
  "version": "1.8.0",
  "description": "<%=appName%> dashboard",
  "main": "index.js",
  "scripts": {
    "create-app-content": "hygen create-app-content with-prompt --appName <%=appName%>",
    "preview-url": "echo '\nOpen the application by accessing these URL: \n\\033[32mhttps://<%=appName%>-dashboard.pawon.local\\033[0m'",
    "preinstall": "npx only-allow pnpm",
    "prepare": "zx --quiet scripts/prepare.js",
    "predev": "pnpm prepare && pnpm -s preview-url",
    "prebuild": "pnpm prepare",
    "prestart": "pnpm -s preview-url",
    "dev": "next dev",
    "build": "next build",
    "start": "npx serve@latest out",
    "prod": "pnpm build && pnpm start",
    "type:check": "tsc"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "@hookform/resolvers": "^3.3.4",
    "@types/crypto-js": "^4.2.2",
    "axios": "^1.6.4",
    "clsx": "^1.2.1",
    "crypto-js": "^4.2.0",
    "dayjs": "^1.11.10",
    "dompurify": "^3.0.8",
    "flowbite": "^2.2.1",
    "flowbite-react": "^0.9.0",
    "jsoneditor": "^10.0.3",
    "next": "^14.0.4",
    "omit-empty": "^1.0.0",
    "react": "^18.2.0",
    "react-apexcharts": "^1.4.1",
    "react-dom": "^18.2.0",
    "react-hook-form": "^7.49.2",
    "react-icons": "^5.0.0",
    "react-quill": "^2.0.0",
    "react-sortablejs": "^6.1.4",
    "react-tailwindcss-select": "^1.8.5",
    "sharp": "^0.33.1",
    "svgmap": "^2.10.1",
    "tailwind-merge": "^2.2.0",
    "universal-cookie": "^7.0.1",
    "uuid": "^9.0.1",
    "zod": "^3.22.4",
    "zx": "^7.2.3"
  },
  "devDependencies": {
    "@commitlint/cli": "18.4.4",
    "@commitlint/config-conventional": "18.4.4",
    "@faker-js/faker": "^8.3.1",
    "@next/eslint-plugin-next": "^14.0.4",
    "@types/dompurify": "^3.0.5",
    "@types/jsoneditor": "^9.9.5",
    "@types/node": "^20.10.6",
    "@types/react": "^18.2.46",
    "@types/react-dom": "^18.2.18",
    "@types/uuid": "^9.0.8",
    "@typescript-eslint/eslint-plugin": "^7.0.0",
    "@typescript-eslint/parser": "^7.0.0",
    "autoprefixer": "^10.4.16",
    "danger": "^11.3.1",
    "danger-plugin-conventional-commitlint": "^3.0.0",
    "ejs-lint": "^2.0.0",
    "eslint-config-prettier": "^9.1.0",
    "eslint-plugin-jsx-a11y": "^6.8.0",
    "eslint-plugin-prettier": "^5.1.2",
    "eslint-plugin-react": "^7.33.2",
    "eslint-plugin-react-hooks": "^4.6.0",
    "eslint-plugin-tailwindcss": "^3.13.1",
    "husky": "^8.0.3",
    "lint-staged": "^15.2.0",
    "postcss": "^8.4.33",
    "prettier": "^3.1.1",
    "prettier-plugin-organize-imports": "^3.2.4",
    "prettier-plugin-tailwindcss": "^0.5.10",
    "tailwindcss": "^3.4.0",
    "typescript": "^5.3.3"
  },
  "engines": {
    "node": "^20.9.0",
    "pnpm": "^8.0.0"
  },
  "lint-staged": {
    "*.@(js|jsx|ts|tsx|ejs.t)": [
      "pnpm format",
      "pnpm format:check",
      "pnpm lint",
      "bash -c \"pnpm type:check\""
    ]
  }
}

