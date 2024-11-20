---
to: "<%= appDeploy.startsWith('gke') ? `.github/workflows/deploy-prod-${appName}.yaml` : null %>"
---
name: Deploy Prod <%=h.changeCase.titleCase(appName)%>

on:
  release:
    types: [released]

env:
  ENV: prod
  ENV_NAME: prod

concurrency:
  group: deploy-prod-<%=appName%>
  cancel-in-progress: ${{ startsWith(github.ref, 'refs/tags/<%=appName%>') }}

jobs:
  build-push:
    runs-on: ktbs-build-deploy-runner
    if: startsWith(github.ref, 'refs/tags/<%=appName%>')
    steps:
      - name: Run build & push
        uses: kitabisa/composite-actions/frontend/build@v2
        with:
          working_directory: ./apps/<%=appName%>
          project_id: <%= appConfig['prod']['project_id'] %>
          credentials_json: <%= appConfig['prod']['credentials_json'] %>
          artifact_registry_host: <%= appConfig['prod']['artifact_registry_host'] %>
          artifact_registry_project_id: ${{ secrets.GCP_PROJECT_ID_INFRA }}
          setup_pnpm: true
          pnpm_version: 8
          using_nextjs: true

  deploy:
    runs-on: ktbs-build-deploy-runner
    needs: build-push
    steps:
      - name: Run deploy & prune
        uses: kitabisa/composite-actions/frontend/deploy@v2
        with:
          working_directory: ./apps/<%=appName%>
          project_id: <%= appConfig['prod']['project_id'] %>
          credentials_json: <%= appConfig['prod']['credentials_json'] %>
          gke_cluster_name: <%= appConfig['prod']['gke_cluster_name'] %>
          gke_cluster_zone: <%= appConfig['prod']['gke_cluster_zone'] %>
          artifact_registry_host: <%= appConfig['prod']['artifact_registry_host'] %>
          artifact_registry_project_id: ${{ secrets.GCP_PROJECT_ID_INFRA }}
          rancher_cluster_id: <%= appConfig['prod']['rancher_cluster_id'] %>
          rancher_host: ${{ secrets.RANCHER_CATTLE_HOST }}
          rancher_access_key: ${{ secrets.RANCHER_CATTLE_ACCESS_KEY }}
          rancher_secret_key: ${{ secrets.RANCHER_CATTLE_SECRET_KEY }}
