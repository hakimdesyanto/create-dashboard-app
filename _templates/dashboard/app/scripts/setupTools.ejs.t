---
to: scripts/setupTools.js
---

#!/usr/bin/env zx

async function setupPnpm() {
  await $`brew install pnpm@8`
}

async function setupHygen() {
  await $`brew tap jondot/tap`
  await $`brew install hygen`
}

async function setupNginx() {
  try {
    await $`brew install nginx`
  } catch (_e) {}
  await $`mkdir -p $HOMEBREW_PREFIX/etc/nginx/certs`
  await $`cd $HOMEBREW_PREFIX/etc/nginx/certs && npx --yes create-ssl-certificate --hostname pawon --domain local`
  await $`mv $HOMEBREW_PREFIX/etc/nginx/certs/ssl.crt $HOMEBREW_PREFIX/etc/nginx/certs/pawon.local.crt`
  await $`mv $HOMEBREW_PREFIX/etc/nginx/certs/ssl.key $HOMEBREW_PREFIX/etc/nginx/certs/pawon.local.key`
  try {
    await $`sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain $HOMEBREW_PREFIX/etc/nginx/certs/pawon.local.crt`
  } catch (_e) {}
}

async function setupHelmSecrets() {
  try {
    await $`brew install kubectl`
  } catch (_e) {}
  await $`brew install helm`
  try {
    await $`brew install python@3.10`
  } catch (_e) {}
  try {
    await $`export CLOUDSDK_PYTHON=/opt/homebrew/bin/python3.10`
    await $`brew install --cask google-cloud-sdk`
  } catch (_e) {}
  await $`brew install yq`
  await $`brew install sops`
  await $`brew install gnu-getopt`
  try {
    await $`helm plugin install https://github.com/jkroepke/helm-secrets`
  } catch (_e) {}
  await $`gcloud auth application-default login`
}

void (async function () {
  if (!process.env.CI) {
    await $`sudo -v`
    await setupPnpm()
    await setupHygen()
    await setupNginx()
    await setupHelmSecrets()
  }
})()
