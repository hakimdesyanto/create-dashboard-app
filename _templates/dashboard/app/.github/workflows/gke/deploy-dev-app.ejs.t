---
to: "<%= appDeploy.startsWith('gke') ? `.github/workflows/deploy-dev-${appName}.yaml` : null %>"
---
name: Deploy Dev <%=h.changeCase.titleCase(appName)%>

on:
  pull_request_review:
    types: [submitted]

env:
  ENV: stg
  ENV_NAME: dev-${{ github.event.pull_request.number }}

concurrency:
  group: deploy-dev-<%=appName%>-${{ github.event.pull_request.number }}-${{ github.event.review.state }}
  cancel-in-progress: ${{ contains(github.event.review.body, '/deploy-<%=appName%>') || contains(github.event.review.body, '/deploy-all') }}

jobs:
  build-push:
    runs-on: ktbs-build-deploy-runner
    if: contains(github.event.review.body, '/deploy-<%=appName%>') || contains(github.event.review.body, '/deploy-all')
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
          preview_url: <%= appConfig['stg']['preview_url'][appDeploy] %>

  destroy-on-fail:
    runs-on: ktbs-small-runner
    needs: deploy
    if: ${{ failure() }}
    steps:
      - name: Run destroy
        uses: kitabisa/composite-actions/frontend/destroy@v2
        with:
          working_directory: ./apps/<%=appName%>
          project_id: <%= appConfig['stg']['project_id'] %>
          credentials_json: <%= appConfig['stg']['credentials_json'] %>
          gke_cluster_name: <%= appConfig['stg']['gke_cluster_name'] %>
          gke_cluster_zone: <%= appConfig['stg']['gke_cluster_zone'] %>
          artifact_registry_host: <%= appConfig['stg']['artifact_registry_host'] %>
