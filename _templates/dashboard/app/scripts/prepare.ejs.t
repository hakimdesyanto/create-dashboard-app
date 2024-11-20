---
to: scripts/prepare.js
---

#!/usr/bin/env zx

async function generateConfigEnv() {
  try {
    await $`yq eval .config.data[] .local/helm/local/config.yaml > .env.config`
  } catch (_e) {
    // eslint-disable-next-line no-console
    console.log('yq is not available, installing yq with brew')
    await $`brew install yq`
    await $`yq eval .config.data[] .local/helm/local/config.yaml > .env.config`
  }
  // eslint-disable-next-line no-console
  console.log('config.env has generated (temporary)')
  return
}

async function generateSecretEnv() {
  try {
    await $`sops -d --extract '["secret"]["data"]["secret.env"]' .local/helm/local/secret.yaml > .env.secret`
  } catch (_e) {
    // eslint-disable-next-line no-console
    console.log('sops is not available, installing sops with brew')
    await $`brew install sops`
    await $`sops -d --extract '["secret"]["data"]["secret.env"]' .local/helm/local/secret.yaml > .env.secret`
  }
  // eslint-disable-next-line no-console
  console.log('secret.env has generated (temporary)')
  return
}

async function generateEnv() {
  await $`chmod 644 .env || :`
  await generateConfigEnv()
  await generateSecretEnv()
  await $`cat .env.config .env.secret > .env`
  await $`rm .env.config .env.secret`
  await $`chmod 444 .env`
  // eslint-disable-next-line no-console
  console.log('.env has generated')
  return
}

void (async function () {
  if (!process.env.CI) {
    await generateEnv()
  }
})()
