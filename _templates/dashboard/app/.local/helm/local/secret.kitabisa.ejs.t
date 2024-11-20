---
to: "<%= appBusinessUnit === 'kitabisa' ? `.local/helm/local/secret.yaml` : null %>"
---
secret:
    enabled: ENC[AES256_GCM,data:c+NeCQ==,iv:0iLAyvMdLSQm4ZxDRPInYgJI8WwHSzCR/hZCWbM4yEs=,tag:haXXFjKqfE5gf3IBo6zd0Q==,type:bool]
    data:
        secret.env: ENC[AES256_GCM,data:L0IHaQ/HfB+5Dp10Edko1W0WNnRfodgGyxLCI5I6CQQnV110g5fZMvqN/aYBhTMkgHbCdupjfkKwTpVYvDwYKosSHUo0J5BsCpEhNgXg4CoPfX7zURTxT1exH1OVzM3xjZMEOeQm/etEaiUcwkPCUIRwdXiGnN6VkZbjnLN9Fp5hs+lcmBMStlorITmVckv9gQkRafTHlbJ0EiSTJfMdXGxVnCP/Mc3JD7vFubniTfAQq+A+OsTExC3b7kp26F6EkjwLTQ9K6QP9707lO5ugNz7DrSyyu+VKZEsOQqdCp7SytYrrhAEcI6aIiXu60PWjPSbtqwPtr/UPAta0qB/lNnDxd2cyrlG98o72sWoAbZbRhCcDVIQTBACXPPFVMV2fTRCOnFGtjtOQa+hD+9anYK+f+eYNzH8v1WEryhSwDNK+w0EGd1I=,iv:dDzQdz72IXiQDGS2D4j7n+CpH8OtLG/iPUe3J9yqZVI=,tag:jVreaappEbWvZubdOrhaPQ==,type:str]
sops:
    kms: []
    gcp_kms:
        - resource_id: projects/kitabisa-stg/locations/global/keyRings/sops/cryptoKeys/sops-key
          created_at: "2024-01-16T16:19:16Z"
          enc: CiQAS2FqNe5LjbfGoklpQf8rT8cLlWWhoxDLC/oioRnAybh4BqsSSQB/YcCYTe8NiNbeixFuDEEgwrX04KZqvV939kyF+8reR92rBzD3qU226Yp1NbVYIhNTpR7dzRkYC72m2plfMwZGT9A10hOSRcA=
    azure_kv: []
    hc_vault: []
    age: []
    lastmodified: "2024-04-25T18:04:25Z"
    mac: ENC[AES256_GCM,data:GtvvYWxHQTW58pcY3w7ij6ZLmvaBndPw737GxqOTT49IVSsWPZc1dDtAyHp7mwcsb7UhbxQlE7dI7poPdo0aoyI9B2rRkLSMKYnxjsVi9b0jZmnvDI2ITJENw0rSHBJsrOMcuQ64vqlgaguToZYgo2WEFXTn7NXfdMVdWsrIhTE=,iv:kFL4Yo0cIjgPDJ0NzCr//pOiHeVPb7g2p5O7ECo6Gzc=,tag:4jx6ekT1eU8yHrIyATgOYA==,type:str]
    pgp: []
    unencrypted_suffix: _unencrypted
    version: 3.8.1
