---
to: "<%= appDeploy.startsWith('cloudflare-pages') ? `.github/workflows/deploy-dev-${appName}.yaml` : null %>"
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
  build-push-deploy:
    runs-on: ktbs-build-deploy-runner
    if: contains(github.event.review.body, '/deploy-<%=appName%>') || contains(github.event.review.body, '/deploy-all')
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
          deployment_branch: ${{ github.ref }}
          production_branch: main
          package_manager: pnpm
          build_directory: ./out
          project_name: <%=appName%>-dashboard-stg
          project_domain_zone: pawon.co
          project_custom_domain: <%= appConfig['stg']['preview_url'][appDeploy] %>
