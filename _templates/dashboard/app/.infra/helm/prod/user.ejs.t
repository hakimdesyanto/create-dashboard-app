---
to: "<%= appDeploy.startsWith('gke') ? `.infra/helm/prod/user.yaml` : null %>"
---
user:
  names:
    - adeherysh
    - muhilham
    - octosa-kitabisa
    - ugi-kitabisa
    - famrullah11
