---
to: .local/helm/local/config.yaml
---
config:
  enabled: true
  data:
    config.env: |-
      NODE_ENV='development'
      NEXT_PUBLIC_BUILD_ENV='local'
      NEXT_PUBLIC_SERVICE_BASE_API='https://geni.kitabisa.xyz/<%=appName%>'
      NEXT_PUBLIC_SERVICE_GUDANG_API='https://geni.kitabisa.us/gudang'
      NEXT_PUBLIC_SERVICE_GUDANG_IMGIX_URL='https://gudang-dev.kitabisa.com'
      NEXT_PUBLIC_SERVICE_SMOCKR_API='https://smockr.kitabisa.xyz'