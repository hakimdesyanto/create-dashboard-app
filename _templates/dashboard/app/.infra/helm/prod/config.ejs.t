---
to: .infra/helm/prod/config.yaml
---
config:
  enabled: true
  data:
    config.env: |-
      NODE_ENV='production'
      NEXT_PUBLIC_BUILD_ENV='prod'
      NEXT_PUBLIC_SERVICE_BASE_API='https://geni.kitabisa.com/<%=appName%>'
      NEXT_PUBLIC_SERVICE_GUDANG_API='https://geni.kitabisa.com/gudang'
      NEXT_PUBLIC_SERVICE_GUDANG_IMGIX_URL='https://gudang-prod.kitabisa.com'