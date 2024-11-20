---
to: "<%= appDeploy.startsWith('gke') ? `.infra/helm/volume.yaml` : null %>"
---
secrets:
  volumes:
    - name: '{{ .Values.meta.name }}-config-{{ .Values.meta.env }}'
      mounts:
        - mountPath: '/opt/{{ .Values.meta.name }}/params/secret.env'
          subPath: secret.env
          readOnly: true

configMaps:
  volumes:
    - name: '{{ .Values.meta.name }}-config-{{ .Values.meta.env }}'
      mounts:
        - mountPath: '/opt/{{ .Values.meta.name }}/params/config.env'
          subPath: config.env
          readOnly: true

extraVolumes:
  - name: tmp
    emptyDir: {}

extraVolumeMounts:
  - name: tmp
    mountPath: /tmp