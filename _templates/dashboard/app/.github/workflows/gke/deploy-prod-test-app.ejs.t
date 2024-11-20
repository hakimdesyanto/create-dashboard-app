---
to: "<%= appDeploy.startsWith('gke') ? `.github/workflows/deploy-prod-test-${appName}.yaml` : null %>"
---
name: Deploy Prod Test <%=h.changeCase.titleCase(appName)%>

on: workflow_dispatch

env:
  ENV: prod-test
  ENV_NAME: prod-test

concurrency:
  group: deploy-prod-test-<%=appName%>
  cancel-in-progress: true

jobs:
  build-push:
    runs-on: ktbs-build-deploy-runner
    steps:
      - name: Run build & push
        uses: kitabisa/composite-actions/frontend/build@v2
        with:
          working_directory: ./apps/<%=appName%>
          project_id: <%= appConfig['prod-test']['project_id'] %>
          credentials_json: <%= appConfig['prod-test']['credentials_json'] %>
          artifact_registry_host: <%= appConfig['prod-test']['artifact_registry_host'] %>
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
          project_id: <%= appConfig['prod-test']['project_id'] %>
          credentials_json: <%= appConfig['prod-test']['credentials_json'] %>
          gke_cluster_name: <%= appConfig['prod-test']['gke_cluster_name'] %>
          gke_cluster_zone: <%= appConfig['prod-test']['gke_cluster_zone'] %>
          artifact_registry_host: <%= appConfig['prod-test']['artifact_registry_host'] %>
          artifact_registry_project_id: ${{ secrets.GCP_PROJECT_ID_INFRA }}
          rancher_cluster_id: <%= appConfig['prod-test']['rancher_cluster_id'] %>
          rancher_host: ${{ secrets.RANCHER_CATTLE_HOST }}
          rancher_access_key: ${{ secrets.RANCHER_CATTLE_ACCESS_KEY }}
          rancher_secret_key: ${{ secrets.RANCHER_CATTLE_SECRET_KEY }}
