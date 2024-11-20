---
to: "<%= appDeploy.startsWith('gke') ? `.infra/helm/stg/user.yaml` : null %>"
---
user:
  names:
    - adeherysh
    - muhilham
    - octosa-kitabisa
    - ugi-kitabisa
    - famrullah11
