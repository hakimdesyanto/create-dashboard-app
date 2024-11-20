---
to: .sops.yaml
---
creation_rules:
<% if (appBusinessUnit === 'kitajaga') { -%>
  - path_regex: .local/helm/local/*
    gcp_kms: projects/kitajaga-stg/locations/global/keyRings/sops/cryptoKeys/sops-key

  - path_regex: .infra/helm/stg/*
    gcp_kms: projects/kitajaga-stg/locations/global/keyRings/sops/cryptoKeys/sops-key

  - path_regex: .infra/helm/prod-test/*
    gcp_kms: projects/kitajaga/locations/global/keyRings/sops/cryptoKeys/sops-key

  - path_regex: .infra/helm/prod/*
    gcp_kms: projects/kitajaga/locations/global/keyRings/sops/cryptoKeys/sops-key
<% } else if (appBusinessUnit === 'kitabisa-life') { -%>
  - path_regex: .local/helm/local/*
    gcp_kms: projects/kitabisa-life-staging/locations/global/keyRings/sops/cryptoKeys/sops-key

  - path_regex: .infra/helm/stg/*
    gcp_kms: projects/kitabisa-life-staging/locations/global/keyRings/sops/cryptoKeys/sops-key

  - path_regex: .infra/helm/prod-test/*
    gcp_kms: projects/kitabisa-life/locations/global/keyRings/sops/cryptoKeys/sops-key

  - path_regex: .infra/helm/prod/*
    gcp_kms: projects/kitabisa-life/locations/global/keyRings/sops/cryptoKeys/sops-key
<% } else { -%>
  - path_regex: .local/helm/local/*
    gcp_kms: projects/kitabisa-stg/locations/global/keyRings/sops/cryptoKeys/sops-key

  - path_regex: .infra/helm/stg/*
    gcp_kms: projects/kitabisa-stg/locations/global/keyRings/sops/cryptoKeys/sops-key

  - path_regex: .infra/helm/prod-test/*
    gcp_kms: projects/kitabisa/locations/global/keyRings/sops/cryptoKeys/sops-key

  - path_regex: .infra/helm/prod/*
    gcp_kms: projects/kitabisa/locations/global/keyRings/sops/cryptoKeys/sops-key
<% } -%>
