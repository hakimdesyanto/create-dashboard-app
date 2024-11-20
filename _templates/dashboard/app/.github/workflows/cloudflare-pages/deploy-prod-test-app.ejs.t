---
to: "<%= appDeploy.startsWith('cloudflare-pages') ? `.github/workflows/deploy-prod-test-${appName}.yaml` : null %>"
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
  build-push-deploy:
    runs-on: ktbs-build-deploy-runner
    steps:
      - name: Build
        uses: kitabisa/composite-actions/frontend/build@v2
        with:
          working_directory: ./<%=appName%>
          project_id: <%= appConfig['prod-test']['project_id'] %>
          credentials_json: <%= appConfig['prod-test']['credentials_json'] %>
          artifact_registry_host: <%= appConfig['prod-test']['artifact_registry_host'] %>
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
          deployment_branch: ${{ github.ref }}
          production_branch: release
          package_manager: pnpm
          build_directory: ./out
          project_name: <%=appName%>-dashboard-prod
          project_domain_zone: pawon.io
          project_custom_domain: ${{ env.ENV_NAME }}-<%=appName%>-dashboard.pawon.io
