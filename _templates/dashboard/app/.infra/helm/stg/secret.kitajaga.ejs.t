---
to: "<%= appBusinessUnit === 'kitajaga' ? `.infra/helm/stg/secret.yaml` : null %>"
---
secret:
    enabled: ENC[AES256_GCM,data:Whq7XA==,iv:U7ukPXnBmfsTTX6iW7DyUMfrnOLl3dbx+ugP1JgLUxo=,tag:CzRrKBjrmSYaq7jHEYT+gw==,type:bool]
    data:
        secret.env: ENC[AES256_GCM,data:5rAVRXtCyiRFbDP1RpocU6ZFjtnxC4Px2vns5v/urTrae+u2KBgsyBkIvybZsj2Y9sXUuwaWyERhv50R9T+7vYrBG1hKdCwWxX7gOvnCft7WjFpLv63twvX8I44ktxXX9eTsVublQrwX/ejbUgHsZ3GmQQB6cBZsEhAuatnOVAUShotaZVRo6bGH6qlltNzGaq7V1gwEZcmu73P2DR+1U/y4mg7Dlyg41eugXtsRFhi20ImxwnW8nMns3uGKiqsCKPvKbl1lC6xlfi1rhPebDkI3L9csJp5zruUwoEJodIv6PKxAC0vzGYNLZiZ1kxfSfRY00pG3UUkCLQdxLHoC1lbH5+PU3zfQgT0w36C3jHWaNg7HMruTPXZy1rb/xRzFrRDGklUphiAtOyk6aJc52HS5MLSKJV3L8f031/baGcr2u7k6nB0=,iv:dWSECg+JGRfnOF9xra3t3tsDMdZxomoznKXYFI6ifos=,tag:5FJ5tJzHq2N71vvYVUN6+A==,type:str]
sops:
    kms: []
    gcp_kms:
        - resource_id: projects/kitajaga-stg/locations/global/keyRings/sops/cryptoKeys/sops-key
          created_at: "2024-03-13T04:55:15Z"
          enc: CiQAVcQhNsXd9URgGcZ4C+s5MUbhKMIw9Gg5Kf9+QedYx51YuO0SSQC2DaKHAzkCozt/BPYzAFd+E2NL4mbQmkMA/22qtPQN5o+Ac8rxv09QLmUY2T0VFEW3dh52YxM5YRAt+4YdZJsZmMzXUFZ+A7c=
    azure_kv: []
    hc_vault: []
    age: []
    lastmodified: "2024-04-25T18:14:03Z"
    mac: ENC[AES256_GCM,data:wBbP+NXFDlyPEmQ7uoxcSdiY5UNUV4JwMAqZvtLvjDurFM8/45dEVFLtiBdHA/VBOAJ3dDwgwxmvOeRwM6iT/iiRUQoocW/Rx/FeTGI7N2Zj4sYDx/mU9VWaSJH2Pfwo1uFNj6fGWW9zRC4tuIbeWREP7nlkckkLfwafahz+PVE=,iv:dFrc2sydBg5YihDjnQ8a1Cb+QGDZb6M1jMsENOQS9jY=,tag:yL71rv+R2wgZjo8vwTzVKg==,type:str]
    pgp: []
    unencrypted_suffix: _unencrypted
    version: 3.8.1
