---
to: "<%= appBusinessUnit === 'kitajaga' ? `.infra/helm/prod/secret.yaml` : null %>"
---
secret:
    enabled: ENC[AES256_GCM,data:1EUH9Q==,iv:vhBXP6DvlZWpYvWkYt1/HY7/wYo7hKyCblyPbEtIw88=,tag:+A0Oo+n+wCN3PhnArZk/iA==,type:bool]
    data:
        secret.env: ENC[AES256_GCM,data:7b5gAoCMT34nKGm4Fku2RRWMDNQdHscc0uAIGP1MIxgKP6A/V9DztKTdKQ0Ydm1XcLDR0vHNP0KGd3EzIiNJX/RcZ/hauIXrfH6xhQalYzTNqfd3pGJfnNONr2/RwlNd2LvH41XdiR8LpZEULKhhHyxQKYomBkUg5W3rqYUm18pJXMJ+30FziGpLDcLHHgPClAPhO5iS0UFPTYYmtEHaURBWAib9ywwUOAmCSMBtPT8tXLSolHJWXAk40Pz/mQw6TOBmln86ofqPUMCgiuYZIBWACYajIXb+RuX96pvB2V3aQbP7aSNFKE8=,iv:v72vJu9WW5INDU7W0tvZwHx2ek5HS0hbWkBfrTsEJHs=,tag:I7Wdm2TLdg0HPzH1ZXwPlw==,type:str]
sops:
    kms: []
    gcp_kms:
        - resource_id: projects/kitajaga/locations/global/keyRings/sops/cryptoKeys/sops-key
          created_at: "2024-03-13T04:57:40Z"
          enc: CiQAmAeV6juXMZlh7Qn9uaSVLaVkvUJu/NhMo6aMaQLDNc76JAcSSQCY6LnPA7g9Fq8WGgnOuQCgjqHlccyaVcttlYKzQr0cYvj0J/SMMIjKH2xBccOCN8+gl5wat+uwcEKKmcRLOtq2P4opGycd2no=
    azure_kv: []
    hc_vault: []
    age: []
    lastmodified: "2024-03-13T04:57:41Z"
    mac: ENC[AES256_GCM,data:VgvaRy47JpAklm9QGwZ4GqT8TtxWYEUHEGFyCTsDLj7xZdj7EVOcPi/jAvOAeXDZ+wiR08TzJyc/VrDmxu1zQMybvB/MndzmR3pHHXoFL1KU0CmSSxepw9q9djfVfeJxzSZF1vrNy47wDgdf63rSEQClu6Nf2sAputnnQeFc/gQ=,iv:CvGrWmNPlnQxiXgHc1qcexoKa7G88c9ptzsFtVEWakQ=,tag:tzN+xFtAF8XZ+H9ts/kaig==,type:str]
    pgp: []
    unencrypted_suffix: _unencrypted
    version: 3.8.1
