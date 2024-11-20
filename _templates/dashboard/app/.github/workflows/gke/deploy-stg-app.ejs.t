---
to: "<%= appDeploy.startsWith('gke') ? `.github/workflows/deploy-stg-${appName}.yaml` : null %>"
---
name: Deploy Stg <%=h.changeCase.titleCase(appName)%>

on:
  workflow_dispatch:
  push:
    branches:
      - main
    paths:
      - apps/<%=appName%>/**

env:
  ENV: stg
  ENV_NAME: stg

concurrency:
  group: deploy-stg-<%=appName%>
  cancel-in-progress: true

jobs:
  build-push:
    runs-on: ktbs-build-deploy-runner
    steps:
      - name: Run build & push
        uses: kitabisa/composite-actions/frontend/build@v2
        with:
          working_directory: ./apps/<%=appName%>
          project_id: <%= appConfig['stg']['project_id'] %>
          credentials_json: <%= appConfig['stg']['credentials_json'] %>
          artifact_registry_host: <%= appConfig['stg']['artifact_registry_host'] %>
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
          project_id: <%= appConfig['stg']['project_id'] %>
          credentials_json: <%= appConfig['stg']['credentials_json'] %>
          gke_cluster_name: <%= appConfig['stg']['gke_cluster_name'] %>
          gke_cluster_zone: <%= appConfig['stg']['gke_cluster_zone'] %>
          artifact_registry_host: <%= appConfig['stg']['artifact_registry_host'] %>
          artifact_registry_project_id: ${{ secrets.GCP_PROJECT_ID_INFRA }}
          rancher_cluster_id: <%= appConfig['stg']['rancher_cluster_id'] %>
          rancher_host: ${{ secrets.RANCHER_CATTLE_HOST }}
          rancher_access_key: ${{ secrets.RANCHER_CATTLE_ACCESS_KEY }}
          rancher_secret_key: ${{ secrets.RANCHER_CATTLE_SECRET_KEY }}
