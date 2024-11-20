---
to: .infra/helm/prod-test/config.yaml
---
config:
  enabled: true
  data:
    config.env: |-
      NODE_ENV='production'
      NEXT_PUBLIC_BUILD_ENV='prod-test'
      NEXT_PUBLIC_SERVICE_BASE_API='https://geni.kitabisa.us/<%=appName%>'
      NEXT_PUBLIC_SERVICE_GUDANG_API='https://geni.kitabisa.us/gudang'
      NEXT_PUBLIC_SERVICE_GUDANG_IMGIX_URL='https://gudang-prod.kitabisa.com'