---
to: "<%= appBusinessUnit === 'kitabisa' ? `.infra/helm/stg/secret.yaml` : null %>"
---
secret:
    enabled: ENC[AES256_GCM,data:c+NeCQ==,iv:0iLAyvMdLSQm4ZxDRPInYgJI8WwHSzCR/hZCWbM4yEs=,tag:haXXFjKqfE5gf3IBo6zd0Q==,type:bool]
    data:
        secret.env: ENC[AES256_GCM,data:NQcmrdtdbWzyiKFDFVJrkj2rfomC9MSHizBB2wqD4jZaIB3mnzODMLF3/jKz50PAJyy50BUONUaU7KYeVjpBqiNC7bdSUxrkG5NUGmXhAb5ArIOnUzaguSCGGJFLfKz4V/5N9GTpTgXcJJIenYesNBTyDcP94rZ2UKl26BhSDu1V+H9AkQckWVbCK9DTRudzesxkmiAuPBDGPCGjWj4XFxfncmrXt7GaD5pQx6WaVc05sISNTEGUnwQ8AJtrEfC5QHFQheYgrVsnJ6ECZNo4mhFQBnkkTdfMGyUoTSineYsT2g4amHk9zyevlO2VmMA80MFX7ozwWc7/w3horPUPZXOLCSefC8tFR16Lks6rN2pO69Ocbo6nNDDitb0oECI453PbHil75VIkenA3qyxZxitIIyvNS+yjZIqQUew5ItfnuDyNTL8=,iv:TybRIg0OfbdyMguX9BpHPzRXbFBOr8z1uEWkV1xR4QM=,tag:pWYijH5mjmKeJLG+XKR0oQ==,type:str]
sops:
    kms: []
    gcp_kms:
        - resource_id: projects/kitabisa-stg/locations/global/keyRings/sops/cryptoKeys/sops-key
          created_at: "2024-01-16T16:19:16Z"
          enc: CiQAS2FqNe5LjbfGoklpQf8rT8cLlWWhoxDLC/oioRnAybh4BqsSSQB/YcCYTe8NiNbeixFuDEEgwrX04KZqvV939kyF+8reR92rBzD3qU226Yp1NbVYIhNTpR7dzRkYC72m2plfMwZGT9A10hOSRcA=
    azure_kv: []
    hc_vault: []
    age: []
    lastmodified: "2024-04-25T18:12:55Z"
    mac: ENC[AES256_GCM,data:WLqwOYgF6FPLYr1CubL0RfYT+WcS4tC7kyqhnBt1k26iqCMlIe9T7s3y1J++GOcxNZHOfzxiPEEKZN2Ruij28TS1plxTddWKoI3PeWMHZzrb0h6FU4rbu2Ax3IigimLpU8OZjmQ1eFCzMS+FDhSdbyC9EXJOmMoqooHfr1iLoXM=,iv:GQ5ZaxkkPU73tf8oPp25lSXLbjRLvBj8x/FJh+IKdsE=,tag:X5GDfOQK5k/7LgYe4S6dBg==,type:str]
    pgp: []
    unencrypted_suffix: _unencrypted
    version: 3.8.1
