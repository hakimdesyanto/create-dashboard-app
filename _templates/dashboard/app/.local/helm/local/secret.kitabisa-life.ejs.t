---
to: "<%= appBusinessUnit === 'kitabisa-life' ? `.local/helm/local/secret.yaml` : null %>"
---
secret:
    enabled: ENC[AES256_GCM,data:2bBrpA==,iv:zbO4UdmNrdsp8K3vbsF927fq4fV3dEksVJmp50uRKhA=,tag:X3Y8ccGXa0oop4u1oK4fHg==,type:bool]
    data:
        secret.env: ENC[AES256_GCM,data:BndVDUmgrlyBbK8Cp6cztw/xI6+ye7E0cM3g9dizqz6T8ounLV6SK+VHZ3yO7LTPEcZg+9qFoeUh0k4Kl5dYVMlxjfHRzuGkPY1yC97laGiTjc23yhfd9BLmAmu68c03ELZ6HuTiQfB+YyQ3IHn2Ga27iAHpz5Ao5X8esq6Xgok9aGq3tpxghBUk4U3or8yHFU+apEkQCpeMHLnalKJan8hEu8gcfp7bmkEeCRdZTJdnuuoEqy8zwFlgVjsSk7OsM1xDT4JAAXqj+rCHNPQyODalIWVL4WI4eZ0RPo8tUH04v0Ex5mGbytDr5UYfIeoR3JQFuwIJVGioo2Mw/gKjWFvsaSjNc9cRXUYUUBjV7pTLUoa2cgjiZgcmQ8XsmDr5bO5p/6KHEShKHHM2h41oTe7Rcg7cK6bU/0GiNkLs9OrKruhB5sk=,iv:6KjgQuncloxD2dK+he0Zk8rw2NpwSnm/VVbjq72skDw=,tag:fdPXKuR4q1eayNjjOuULbQ==,type:str]
sops:
    kms: []
    gcp_kms:
        - resource_id: projects/kitabisa-life-staging/locations/global/keyRings/sops/cryptoKeys/sops-key
          created_at: "2024-03-13T04:11:11Z"
          enc: CiQA2edWfaLinJ0u8Jj7j8gf/62kP9T+ddfme49fkbTZVTEXkFwSSQAOXV2In3+uh8dkCMcLmk1LwXMBEf9/R+AWemfJDGvl0NC72V7q8tbEURekz0gJXB22YQF2KhQzWe13y3bkZ5tunyKvcLqkv0I=
    azure_kv: []
    hc_vault: []
    age: []
    lastmodified: "2024-04-25T18:10:29Z"
    mac: ENC[AES256_GCM,data:fbFxZlcneNvR+D+jzClFQahYoFEiJPUNXLrQVV1BLYjnCU5gteZHU2hzNFcvs9zI0o9/DqLLlHNVW2hfa/7yf19oXKiyAJORZ91sOUvb124qKgDPOGNBmrWT3Oy0JBY35abqvLK4mQbh35/c5MIKkCBeKk18XSIbBshxHuJCDqA=,iv:dYAkMUJaNzU8Whjk5KgckUYQwpu+reQjrYuXc49BQpM=,tag:BCrIPR/PDyeLDJpOyIIRgw==,type:str]
    pgp: []
    unencrypted_suffix: _unencrypted
    version: 3.8.1
