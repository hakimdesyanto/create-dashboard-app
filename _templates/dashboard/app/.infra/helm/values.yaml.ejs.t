---
to: "<%= appDeploy.startsWith('gke') ? `.infra/helm/values.yaml.gotmpl` : null %>"
---
meta:
  name: {{ requiredEnv "APP_NAME" }}
  env: {{ requiredEnv "ENV_NAME" }}
  version: {{ requiredEnv "VERSION" | quote }}
  squad: {{ requiredEnv "SQUAD" }}
  business: {{ requiredEnv "BUSINESS" }}

image:
  repository: {{ requiredEnv "DOCKER_REPOSITORY" }}/{{ requiredEnv "APP_NAME" }}
  tag: {{ requiredEnv "VERSION" }}-{{ requiredEnv "ENV_NAME" }}
