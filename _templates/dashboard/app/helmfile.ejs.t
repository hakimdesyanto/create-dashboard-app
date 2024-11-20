---
to: "<%= appDeploy.startsWith('gke') ? `helmfile.yaml` : null %>"
---
helmfiles:
  - .infra/helm/helmfile.yaml
