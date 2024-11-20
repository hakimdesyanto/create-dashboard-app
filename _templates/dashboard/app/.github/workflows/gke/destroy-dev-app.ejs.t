---
to: "<%= appDeploy.startsWith('gke') ? `.github/workflows/destroy-dev-${appName}.yaml` : null %>"
---
name: Destroy Dev <%=h.changeCase.titleCase(appName)%>

on:
  pull_request:
    types: [closed]
    paths:
      - apps/<%=appName%>/**

env:
  ENV: stg
  ENV_NAME: dev-${{ github.event.pull_request.number }}

jobs:
  destroy:
    runs-on: ktbs-small-runner
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
          prune_all: true
