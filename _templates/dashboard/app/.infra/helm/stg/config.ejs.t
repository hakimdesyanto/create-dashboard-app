---
to: .infra/helm/stg/config.yaml
---
config:
  enabled: true
  data:
    config.env: |-
      NODE_ENV='production'
      NEXT_PUBLIC_BUILD_ENV='stg'
      NEXT_PUBLIC_SERVICE_BASE_API='https://geni.kitabisa.xyz/<%=appName%>'
      NEXT_PUBLIC_SERVICE_GUDANG_API='https://geni.kitabisa.xyz/gudang'
      NEXT_PUBLIC_SERVICE_GUDANG_IMGIX_URL='https://gudang-dev.kitabisa.com'
      NEXT_PUBLIC_SERVICE_SMOCKR_API='https://smockr.kitabisa.xyz'