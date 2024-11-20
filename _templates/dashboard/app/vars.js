const appVars = {
  kitabisa: {
    deployment: ["gke-public", "gke-private", "cloudflare-pages"],
    config: {
      stg: {
        project_id: "${{ secrets.GCP_PROJECT_ID_STG }}",
        credentials_json: "${{ secrets.GCP_SA_KEY_STG }}",
        cloudflare_api_token: "${{ secrets.CLOUDFLARE_API_TOKEN_KITABISA }}",
        cloudflare_account_id: "${{ secrets.CLOUDFLARE_ACCOUNT_ID_KITABISA }}",
        gke_cluster_name: "${{ secrets.GKE_CLUSTER_STGDEV }}",
        gke_cluster_zone: "${{ secrets.GKE_ZONE_STGDEV }}",
        artifact_registry_host: "${{ secrets.ARTIFACT_REGISTRY_HOST }}",
        rancher_cluster_id: "${{ secrets.RANCHER_CATTLE_CLUSTER_ID_STGDEV }}",
        preview_url: {
          "gke-public": "${{ env.ENV_NAME }}-<%=appName%>-dashboard.pawon.co",
          "gke-private": "${{ env.ENV_NAME }}-<%=appName%>-dashboard.stg.kt.bs",
          "cloudflare-pages":
            "${{ env.ENV_NAME }}-<%=appName%>-dashboard.pawon.co",
        },
      },
      prod: {
        project_id: "${{ secrets.GCP_PROJECT_ID_PROD }}",
        credentials_json: "${{ secrets.GCP_SA_KEY_PROD }}",
        cloudflare_api_token: "${{ secrets.CLOUDFLARE_API_TOKEN_KITABISA }}",
        cloudflare_account_id: "${{ secrets.CLOUDFLARE_ACCOUNT_ID_KITABISA }}",
        gke_cluster_name: "${{ secrets.GKE_CLUSTER_PROD }}",
        gke_cluster_zone: "${{ secrets.GKE_ZONE_PROD }}",
        artifact_registry_host: "${{ secrets.ARTIFACT_REGISTRY_HOST }}",
        rancher_cluster_id: "${{ secrets.RANCHER_CATTLE_CLUSTER_ID_PROD }}",
      },
      "prod-test": {
        project_id: "${{ secrets.GCP_PROJECT_ID_PROD }}",
        credentials_json: "${{ secrets.GCP_SA_KEY_PROD }}",
        cloudflare_api_token: "${{ secrets.CLOUDFLARE_API_TOKEN_KITABISA }}",
        cloudflare_account_id: "${{ secrets.CLOUDFLARE_ACCOUNT_ID_KITABISA }}",
        gke_cluster_name: "${{ secrets.GKE_CLUSTER_PROD_TEST }}",
        gke_cluster_zone: "${{ secrets.GKE_ZONE_PROD_TEST }}",
        artifact_registry_host: "${{ secrets.ARTIFACT_REGISTRY_HOST }}",
        rancher_cluster_id:
          "${{ secrets.RANCHER_CATTLE_CLUSTER_ID_PROD_TEST }}",
      },
    },
  },
  kitajaga: {
    deployment: ["gke-public", "gke-private", "cloudflare-pages"],
    config: {
      stg: {
        project_id: "${{ secrets.GCP_PROJECT_ID_KITAJAGA_STG }}",
        credentials_json: "${{ secrets.GCP_SA_KEY_KITAJAGA_STG }}",
        cloudflare_api_token: "${{ secrets.CLOUDFLARE_API_TOKEN_KITABISA }}",
        cloudflare_account_id: "${{ secrets.CLOUDFLARE_ACCOUNT_ID_KITABISA }}",
        gke_cluster_name: "${{ secrets.GKE_CLUSTER_KITAJAGA_STG }}",
        gke_cluster_zone: "${{ secrets.GKE_ZONE_KITAJAGA_STG }}",
        artifact_registry_host: "${{ secrets.ARTIFACT_REGISTRY_HOST_ID }}",
        rancher_cluster_id:
          "${{ secrets.RANCHER_CATTLE_CLUSTER_ID_KITAJAGA_STG }}",
        preview_url: {
          "gke-public": "${{ env.ENV_NAME }}-<%=appName%>-dashboard.pawon.co",
          "gke-private": "${{ env.ENV_NAME }}-<%=appName%>-dashboard.stg.kt.jg",
          "cloudflare-pages":
            "${{ env.ENV_NAME }}-<%=appName%>-dashboard.pawon.co",
        },
      },
      prod: {
        project_id: "${{ secrets.GCP_PROJECT_ID_KITAJAGA_PROD }}",
        credentials_json: "${{ secrets.GCP_SA_KEY_KITAJAGA_PROD }}",
        cloudflare_api_token: "${{ secrets.CLOUDFLARE_API_TOKEN_KITABISA }}",
        cloudflare_account_id: "${{ secrets.CLOUDFLARE_ACCOUNT_ID_KITABISA }}",
        gke_cluster_name: "${{ secrets.GKE_CLUSTER_KITAJAGA_PROD }}",
        gke_cluster_zone: "${{ secrets.GKE_ZONE_KITAJAGA_PROD }}",
        artifact_registry_host: "${{ secrets.ARTIFACT_REGISTRY_HOST_ID }}",
        rancher_cluster_id:
          "${{ secrets.RANCHER_CATTLE_CLUSTER_ID_KITAJAGA_PROD }}",
      },
      "prod-test": {
        project_id: "${{ secrets.GCP_PROJECT_ID_KITAJAGA_PROD }}",
        credentials_json: "${{ secrets.GCP_SA_KEY_KITAJAGA_PROD }}",
        cloudflare_api_token: "${{ secrets.CLOUDFLARE_API_TOKEN_KITABISA }}",
        cloudflare_account_id: "${{ secrets.CLOUDFLARE_ACCOUNT_ID_KITABISA }}",
        gke_cluster_name: "${{ secrets.GKE_CLUSTER_KITAJAGA_PROD_TEST }}",
        gke_cluster_zone: "${{ secrets.GKE_ZONE_KITAJAGA_PROD_TEST }}",
        artifact_registry_host: "${{ secrets.ARTIFACT_REGISTRY_HOST_ID }}",
        rancher_cluster_id:
          "${{ secrets.RANCHER_CATTLE_CLUSTER_ID_KITAJAGA_PROD_TEST }}",
      },
    },
  },
  "kitabisa-life": {
    deployment: ["cloudflare-pages"],
    config: {
      stg: {
        project_id: "${{ secrets.GCP_PROJECT_ID_KITABISA_LIFE_STG }}",
        credentials_json: "${{ secrets.GCP_SA_KEY_KITABISA_LIFE_STG }}",
        cloudflare_api_token: "${{ secrets.CLOUDFLARE_API_TOKEN_KITABISA }}",
        cloudflare_account_id: "${{ secrets.CLOUDFLARE_ACCOUNT_ID_KITABISA }}",
        gke_cluster_name: "",
        gke_cluster_zone: "",
        artifact_registry_host: "${{ secrets.ARTIFACT_REGISTRY_HOST }}",
        rancher_cluster_id: "",
        preview_url: {
          "gke-public": "",
          "gke-private": "",
          "cloudflare-pages":
            "${{ env.ENV_NAME }}-<%=appName%>-dashboard.pawon.co",
        },
      },
      prod: {
        project_id: "${{ secrets.GCP_PROJECT_ID_KITABISA_LIFE_PROD }}",
        credentials_json: "${{ secrets.GCP_SA_KEY_KITABISA_LIFE_PROD }}",
        cloudflare_api_token: "${{ secrets.CLOUDFLARE_API_TOKEN_KITABISA }}",
        cloudflare_account_id: "${{ secrets.CLOUDFLARE_ACCOUNT_ID_KITABISA }}",
        gke_cluster_name: "",
        gke_cluster_zone: "",
        artifact_registry_host: "${{ secrets.ARTIFACT_REGISTRY_HOST }}",
        rancher_cluster_id: "",
      },
      "prod-test": {
        project_id: "${{ secrets.GCP_PROJECT_ID_KITABISA_LIFE_PROD }}",
        credentials_json: "${{ secrets.GCP_SA_KEY_KITABISA_LIFE_PROD }}",
        cloudflare_api_token: "${{ secrets.CLOUDFLARE_API_TOKEN_KITABISA }}",
        cloudflare_account_id: "${{ secrets.CLOUDFLARE_ACCOUNT_ID_KITABISA }}",
        gke_cluster_name: "",
        gke_cluster_zone: "",
        artifact_registry_host: "${{ secrets.ARTIFACT_REGISTRY_HOST }}",
        rancher_cluster_id: "",
      },
    },
  },
};

module.exports = { appVars };
