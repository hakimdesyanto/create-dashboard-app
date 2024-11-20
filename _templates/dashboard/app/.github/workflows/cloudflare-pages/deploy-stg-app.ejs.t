---
to: "<%= appDeploy.startsWith('cloudflare-pages') ? `.github/workflows/deploy-stg-${appName}.yaml` : null %>"
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
  build-push-deploy:
    runs-on: ktbs-build-deploy-runner
    steps:
      - name: Build
        uses: kitabisa/composite-actions/frontend/build@v2
        with:
          working_directory: ./<%=appName%>
          project_id: <%= appConfig['stg']['project_id'] %>
          credentials_json: <%= appConfig['stg']['credentials_json'] %>
          artifact_registry_host: <%= appConfig['stg']['artifact_registry_host'] %>
          artifact_registry_project_id: ${{ secrets.GCP_PROJECT_ID_INFRA }}
          setup_pnpm: true
          pnpm_version: 8
          using_nextjs: true
          package: false

      - name: Deploy
        uses: kitabisa/composite-actions/frontend/deploy/cfpages@v2
        with:
          working_directory: ./<%=appName%>
          cloudflare_api_token: <%= appConfig['stg']['cloudflare_api_token'] %>
          cloudflare_account_id: <%= appConfig['stg']['cloudflare_account_id'] %>
          deployment_branch: main
          production_branch: main
          package_manager: pnpm
          build_directory: ./out
          project_name: <%=appName%>-dashboard-stg
          project_domain_zone: pawon.co
          project_custom_domain: <%=appName%>-dashboard.pawon.co
