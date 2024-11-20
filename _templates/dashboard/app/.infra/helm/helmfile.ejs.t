---
to: "<%= appDeploy.startsWith('gke') ? `.infra/helm/helmfile.yaml` : null %>"
---
repositories:
  - name: kitabisa
    url: {{ requiredEnv "CHARTS_REPOSITORY" }}
    oci: true

releases:
  - name: {{ requiredEnv "APP_NAME" }}-config-{{ requiredEnv "ENV_NAME" }}
    namespace: {{ requiredEnv "APP_NAME" }}
    labels:
      tier: config
      type: main
    chart: kitabisa/config
    version: ~0.5.1
    values:
      - {{ requiredEnv "ENV" }}/config.yaml
      - values.yaml.gotmpl
    secrets:
      - {{ requiredEnv "ENV" }}/secret.yaml

  - name: {{ requiredEnv "APP_NAME" }}-server-{{ requiredEnv "ENV_NAME" }}
    namespace: {{ requiredEnv "APP_NAME" }}
    labels:
      tier: app
      type: main
    chart: kitabisa/app
    version: ~1.1.0-rc
    values:
      - {{ requiredEnv "ENV" }}/server.yaml
      - volume.yaml
      - values.yaml.gotmpl
    needs:
      - {{ requiredEnv "APP_NAME" }}/{{ requiredEnv "APP_NAME" }}-config-{{ requiredEnv "ENV_NAME" }}

  - name: {{ requiredEnv "APP_NAME" }}-user-{{ requiredEnv "ENV_NAME" }}
    namespace: {{ requiredEnv "APP_NAME" }}
    labels:
      tier: user
      type: main
    chart: kitabisa/user
    version: ~0.4.0
    values:
      - {{ requiredEnv "ENV" }}/user.yaml
      - values.yaml.gotmpl

  - name: {{ requiredEnv "APP_NAME" }}-debugger
    namespace: {{ requiredEnv "APP_NAME" }}
    labels:
      tier: debugger
      type: optional
    chart: kitabisa/debugger
    installed: false
