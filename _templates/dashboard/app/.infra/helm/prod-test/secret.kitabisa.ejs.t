---
to: "<%= appBusinessUnit === 'kitabisa' ? `.infra/helm/prod-test/secret.yaml` : null %>"
---
secret:
    enabled: ENC[AES256_GCM,data:uXCenA==,iv:qXLsrrgP8Gz65iSvkrnrmwu3WRDi0eGkyJeejrJHWpo=,tag:htft5E44Ig3zoMUGg8zhxw==,type:bool]
    data:
        secret.env: ENC[AES256_GCM,data:pyU3KG1hx6YCBU8rnSyRpYwHIqH8js++1uUbnrVXwzzNpEl9tFxvAk+j8/CK+48AI9jKGMjMPAHJJegDFMSiHOXXRVkdEvH4wEoWvQy0tR4LegoDmzMcQy9PXj1PNkNgn1tr89yVZxFEbt7xn+1ZEsR+5iycj+6u40AlcCEwBwKdCGo7/LTs9LTsd98e6IqWT5Kvr9OMC5+aN1r/wQQZfzOrb+TLsYwDkWDYR45VgP5wrLmHEyjH2DoZRjYGFrgE4CAdv3MmIqLSUZc21dO1D0BJ6gIFSmjcsxgTjs94KKVKa5rxmT64Qw8=,iv:gdHaSGz1w6v8TpD4dEnsrHb2boRABtuFnY6joFfxXqE=,tag:YVnLtJpDKcGNY469Ewe4hg==,type:str]
sops:
    kms: []
    gcp_kms:
        - resource_id: projects/kitabisa/locations/global/keyRings/sops/cryptoKeys/sops-key
          created_at: "2024-01-16T16:19:03Z"
          enc: CiQAGfyZWSV0clf+JLqOXeEfMwATLEjFd3euYjBiN5M+iQ7+vKUSSQBoVvUJK1cUeRTWkuXJmLYK/tRZPDdQzA9q38+4+sRcqwpnK+iW6epJCfwPPFZfmZxvfdothJOneZodLch91gEHuL3x+GtSWIA=
    azure_kv: []
    hc_vault: []
    age: []
    lastmodified: "2024-04-25T18:20:55Z"
    mac: ENC[AES256_GCM,data:r2hhy9cBu9SLTzdC2iX80RhOquwJGfj+xV3zaYs43MZiPBRM1CEZHL7XMub+DRhTCxMHSs574xMAikCRLCmPxkReURdBVV4sFuKjCIwTfLI/prVHXDEqLw6RI2YIfxkFO89HRmULND0f+u3KNZMRrCRnvHSp2/Hlw1SAU17bHqI=,iv:6TgU2mgn9ms/2LdXERs2QGFA5GFcGYALL0L3r3ABzzQ=,tag:vdx5cnNqtNOc2zQObGgIyA==,type:str]
    pgp: []
    unencrypted_suffix: _unencrypted
    version: 3.8.1
