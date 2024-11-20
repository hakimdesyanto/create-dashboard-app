---
to: "<%= appBusinessUnit === 'kitabisa-life' ? `.infra/helm/stg/secret.yaml` : null %>"
---
secret:
    enabled: ENC[AES256_GCM,data:2bBrpA==,iv:zbO4UdmNrdsp8K3vbsF927fq4fV3dEksVJmp50uRKhA=,tag:X3Y8ccGXa0oop4u1oK4fHg==,type:bool]
    data:
        secret.env: ENC[AES256_GCM,data:d44VQIttzhZ7dgRzv7z8crh5P0l1c8fV7whTvberdIOHQZtZ5wea3PBfIDSMY5XFbeQWRZn+6vIVKxaYcFDLqOghF8hrPGZzYKJa6lkG14DALvMP64FyEPffSjE9emmMfNdLx6UsYsHrUb8YHwPO0nL9uSjyLEiGZUhGNOqvWVh9zGFfQnxKRnofLO4B5Iu/CGC7xX6ckTgB72ue0q6PTPJdTrp20XkPTO4woSHAM2kJ9EmQxGjYF7UJgq8tZBY+pDsFu6pl07gWhLvXM6oaEhAkm7tJuEMo3HrIK5lwJ17FnmT/zKd26JGQc4FGdA+qXavI6PEWsK0X/IBj/xT+WNoRRl8DHQ8IIG1YPDVAcqUOv0HozJSYyJpWhNC9J/lcRLPv5OZuxVPL59SKiAbA5W+l58autx2GMkiXFRMB1CMEB4UibNc=,iv:BBJ/RJzYby4p4RVY9fzTNBYowEz/QpO+BNhSKdTrRKo=,tag:YE12bWd2uCH7KmHMgyNbJQ==,type:str]
sops:
    kms: []
    gcp_kms:
        - resource_id: projects/kitabisa-life-staging/locations/global/keyRings/sops/cryptoKeys/sops-key
          created_at: "2024-03-13T04:11:11Z"
          enc: CiQA2edWfaLinJ0u8Jj7j8gf/62kP9T+ddfme49fkbTZVTEXkFwSSQAOXV2In3+uh8dkCMcLmk1LwXMBEf9/R+AWemfJDGvl0NC72V7q8tbEURekz0gJXB22YQF2KhQzWe13y3bkZ5tunyKvcLqkv0I=
    azure_kv: []
    hc_vault: []
    age: []
    lastmodified: "2024-04-25T18:15:17Z"
    mac: ENC[AES256_GCM,data:VAcSdgyZyXHHYDqYjPBFH7Zrqqchz/A6f+Y+z5BwkoDg9Gz1bTJBew11ycgTM0/dv24TLtFMW9gTykRkKm4s4d5djLwzpjFHxirYe4959+6Frby2ZrWSeIoHnuk+Sm4MEa+Bl7oDwhqQyzq8AJXOoMc2RiFO582fmx255ET5ihg=,iv:RvLDsi+866Fayn3f8VzFbK8UJF8Mz/dex++b5uHsx2g=,tag:IUkQ8jHeiQuqV8KYnjK/ag==,type:str]
    pgp: []
    unencrypted_suffix: _unencrypted
    version: 3.8.1
