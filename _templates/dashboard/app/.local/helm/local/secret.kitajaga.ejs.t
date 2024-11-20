---
to: "<%= appBusinessUnit === 'kitajaga' ? `.local/helm/local/secret.yaml` : null %>"
---
secret:
    enabled: ENC[AES256_GCM,data:Whq7XA==,iv:U7ukPXnBmfsTTX6iW7DyUMfrnOLl3dbx+ugP1JgLUxo=,tag:CzRrKBjrmSYaq7jHEYT+gw==,type:bool]
    data:
        secret.env: ENC[AES256_GCM,data:B3HM2MxBhr4pFm1OHhZIa9rjm9uwGAIfWzyoP9BcJ3nwEpwhn41YH1xagdGkYgfJbgbcgk5hfx/vsCexkHTNzG7ukFDSFl9hV4ExMnkRhozP86MHtnT896FE6jFYCXlQaFT8sSMCZGCTzAtI5T//HEhca+qTwsYbqpK+jOdrBxzlev9W75NUS+nBAoA/Sn8JypLGFdJZ8dlYFwEMyWIblKtH962WLHSLM0ldq+7zsreWa0spq7hMr+JV0CAObXwvZaVnFIZkBMAA7POeKnHY8FehXuUdkDtidrN5A02TCZ9A7XQRW3BSo/0oX0wXGp3zvNYXvM6EpBjjaHptCdGx47s+XPPSD4sEd97SuIhBaJG64gegNgf8psFt5B8TZRAnG8phFGi+F+vOcuw3iwlhQJ8S/uRirGKaWFgZWYzQD/FaP0CLcsc=,iv:GiZsaGW6jpbT13PjhVxGMBxnAfO4DK1DNcWV1KNm0eU=,tag:shwNK7dy9UsCk728O+McIg==,type:str]
sops:
    kms: []
    gcp_kms:
        - resource_id: projects/kitajaga-stg/locations/global/keyRings/sops/cryptoKeys/sops-key
          created_at: "2024-03-13T04:55:15Z"
          enc: CiQAVcQhNsXd9URgGcZ4C+s5MUbhKMIw9Gg5Kf9+QedYx51YuO0SSQC2DaKHAzkCozt/BPYzAFd+E2NL4mbQmkMA/22qtPQN5o+Ac8rxv09QLmUY2T0VFEW3dh52YxM5YRAt+4YdZJsZmMzXUFZ+A7c=
    azure_kv: []
    hc_vault: []
    age: []
    lastmodified: "2024-04-25T18:07:46Z"
    mac: ENC[AES256_GCM,data:sf8S7U6SYSoIg2h57irb9nfqlmiRtF+3YUy9UdJa31BY1VGb3iUw9AAa6k+awqtT8yhFXNcZBsmJZvk93XHhB3ntMZJSsQHuKpuSWYNK8dcDRYG/lBFl2KIjxYO3NhA3MB2263zj6t3rXsFFINjtOh1hiL01xIoHu4oMHMeVVxU=,iv:4XTAhM8qJPMe3zChPK+G6uA6psG7JuSyuOUpsp5nzcI=,tag:s1GRgOf9v4TOmYe6Ouy/8A==,type:str]
    pgp: []
    unencrypted_suffix: _unencrypted
    version: 3.8.1
