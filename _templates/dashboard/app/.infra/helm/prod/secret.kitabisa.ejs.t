---
to: "<%= appBusinessUnit === 'kitabisa' ? `.infra/helm/prod/secret.yaml` : null %>"
---
secret:
    enabled: ENC[AES256_GCM,data:uXCenA==,iv:qXLsrrgP8Gz65iSvkrnrmwu3WRDi0eGkyJeejrJHWpo=,tag:htft5E44Ig3zoMUGg8zhxw==,type:bool]
    data:
        secret.env: ENC[AES256_GCM,data:JxNAeWpHyCZNucH/WtQneoF8cgiEVEDBqLlR/gLeaQrYKr+mD1Jjr4uYhxmbA82wgJJoine2KT7+jI2ozlmPEwcFlyyFRrgAp2hmCGJrD7GrqJerQUvriKhqh5qpJBleof0KJRT3f0OSH/q/WEts8tIsn3DmOP+xZ8R1LJx6HonV9cASzC4UcljkMa/kuHR25gboqeXaLyX6Php1a1ObQFRLjtDNj8nk/m8rZGJcp/51FQgOWh3KfDktkfepR5EHCpWxc1l/NQ8Waon12tF7Bk9vVndW8599G1fyeHGl0bPG05Z4OVs07OU=,iv:Dq2B+CJ5S2/JbpxVTpMAgxpraay51Lrc6Tp72C7nBEg=,tag:2UmBV+9Tu0DNyI6mOAmBxA==,type:str]
sops:
    kms: []
    gcp_kms:
        - resource_id: projects/kitabisa/locations/global/keyRings/sops/cryptoKeys/sops-key
          created_at: "2024-01-16T16:19:03Z"
          enc: CiQAGfyZWSV0clf+JLqOXeEfMwATLEjFd3euYjBiN5M+iQ7+vKUSSQBoVvUJK1cUeRTWkuXJmLYK/tRZPDdQzA9q38+4+sRcqwpnK+iW6epJCfwPPFZfmZxvfdothJOneZodLch91gEHuL3x+GtSWIA=
    azure_kv: []
    hc_vault: []
    age: []
    lastmodified: "2024-04-25T18:18:08Z"
    mac: ENC[AES256_GCM,data:sco8RHLe37QZHeHMbjsMGEtoLaZG4WcAZGAeXgzexXEXOaTp3bmlLRadDsu4+NFLtUTG3c+NaHYIEwXoBrwBFaN06VhZYKYGastHpZCGvig8PJbOSkeTCM9Gl9rUCp+q4GuZubtjtdaOPyJm5hySyZskeXSu5xTK5n9VInrnV4A=,iv:Jnjak4WVP6YsL8nPyvXLozDwrNUMTzGMLxq5hifEcPU=,tag:KHzNxw70lhlHxrCT7FFhTg==,type:str]
    pgp: []
    unencrypted_suffix: _unencrypted
    version: 3.8.1
