---
to: "<%= appDeploy.startsWith('cloudflare-pages') ? `.github/workflows/deploy-prod-${appName}.yaml` : null %>"
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
  build-push-deploy:
    runs-on: ktbs-build-deploy-runner
    if: startsWith(github.ref, 'refs/tags/<%=appName%>')
    steps:
      - name: Build
        uses: kitabisa/composite-actions/frontend/build@v2
        with:
          working_directory: ./<%=appName%>
          project_id: <%= appConfig['prod']['project_id'] %>
          credentials_json: <%= appConfig['prod']['credentials_json'] %>
          artifact_registry_host: <%= appConfig['prod']['artifact_registry_host'] %>
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
          deployment_branch: release
          production_branch: release
          package_manager: pnpm
          build_directory: ./out
          project_name: <%=appName%>-dashboard-prod
          project_domain_zone: pawon.io
          project_custom_domain: <%=appName%>-dashboard.pawon.io
