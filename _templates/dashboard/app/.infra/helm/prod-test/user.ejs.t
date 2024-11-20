---
to: "<%= appDeploy.startsWith('gke') ? `.infra/helm/prod-test/user.yaml` : null %>"
---
user:
  names:
    - adeherysh
    - muhilham
    - octosa-kitabisa
    - ugi-kitabisa
    - famrullah11
