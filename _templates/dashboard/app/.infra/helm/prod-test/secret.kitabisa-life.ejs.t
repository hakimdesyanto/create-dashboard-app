---
to: "<%= appBusinessUnit === 'kitabisa-life' ? `.infra/helm/prod-test/secret.yaml` : null %>"
---
secret:
    enabled: ENC[AES256_GCM,data:Y+k6Pg==,iv:059eb8G9Q8qZt7EA5aeS3EatsS1cEbmwzEfxUZ+jrKs=,tag:noiPQnTFD/JUVM9AYcwWhw==,type:bool]
    data:
        secret.env: ENC[AES256_GCM,data:Lh50uOHVdAJbRi7DBq7XKjzavdRwDtgdDtWr1JM8Bo44SHMR0q+jj7jMlPeXR3MWgCnJN92L8xeWYQM9gf1nP3bfVu+gCGZHQ8/8srJASUZr/fs7c7Xcz2CctOGf6rmhPL5eCi2kLEk62JhGsmxWcTcw0t7963RGAk/FRGv7ioPii+3pJVj2XQm1hPwCiUmKWVvKQbX2k06qLqL5cbn8MyL0Aj6iqO/pYeg9lixN943c3ETSlKcthFFzLIFBTi/TuqYuMi6upDx7UBddHmKU2SexebAWEza3fHjjAGP1mh9G6h0Y2QRNo48=,iv:fxTEM1dU3V/+h5Mh5JBVyhpIrzaa4iesU3b4Y1CHD2s=,tag:hIv9zxvbKcV/ZnjNTKlegQ==,type:str]
sops:
    kms: []
    gcp_kms:
        - resource_id: projects/kitabisa-life/locations/global/keyRings/sops/cryptoKeys/sops-key
          created_at: "2024-03-13T04:22:47Z"
          enc: CiQAaeRk5yFjyDQN/S6hWmJQeSdyXFEvDmsWjpunSfCMeN2b5gYSSQCkoithm6Xjs+eWgrz8ALGOxe4T+oXLSgO1CGVgM2RaTOc8rkEl5PZvNd1MvRDcZL5xYwyMDKhNUQUa+eb38V/4mlmVkeDRdGA=
    azure_kv: []
    hc_vault: []
    age: []
    lastmodified: "2024-03-13T04:22:48Z"
    mac: ENC[AES256_GCM,data:1Sp0nelvSDpD/QEXckD89ICkO5bjLBlIOKdvZ2HKnH7ggbMr/AajVRfnHmtgRGFsiN6d6r4T3Jfppk2D37Ncsbj1MX5sm2mbgkZBxJxJfFRKZc3DnTxBxmo6R2+O9O6aHNAc3/GDP5DLTJfFa04uKiLjd1ir746FHql9hgLam5Q=,iv:yA+03ZvPk2XN/QUT9BT++Mj0a7DC0stEyf+okP7Gu+s=,tag:UzGxONc5Mcbw47EqhTvPzw==,type:str]
    pgp: []
    unencrypted_suffix: _unencrypted
    version: 3.8.1
