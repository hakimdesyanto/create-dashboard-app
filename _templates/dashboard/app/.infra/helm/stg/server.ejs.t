---
to: "<%= appDeploy.startsWith('gke') ? `.infra/helm/stg/server.yaml` : null %>"
---
server:
  enabled: true

  port: 8080

  resources:
    requests:
      cpu: 1m
      memory: 110Mi
    limits:
      memory: 220Mi

  readiness:
    enabled: true
    override:
      tcpSocket:
        port: 8080
      initialDelaySeconds: 5
      periodSeconds: 10

service:
  enabled: true

ingress:
  enabled: true

  annotations:
<% if (appDeploy === 'gke-private') { -%>
    kubernetes.io/ingress.class: nginx-internal
<% } else { -%>
    nginx.ingress.kubernetes.io/configuration-snippet: |-
      more_set_headers "server: ktbs-dtx-server";
      more_set_headers "X-Content-Type-Options: nosniff";
      more_set_headers "X-Xss-Protection: 1; mode=block";
      more_set_headers "Referrer-Policy: strict-origin-when-cross-origin";
      more_set_headers "Content-Security-Policy: upgrade-insecure-requests";
      more_set_headers "X-Powered-By: ktbs-dtx";
<% } -%>

  tls:
    - hosts:
<% if (appBusinessUnit === 'kitabisa' && appDeploy === 'gke-private') { -%>
        - '*.stg.kt.bs'
<% } else if (appBusinessUnit === 'kitajaga' && appDeploy === 'gke-private') { -%>
        - '*.stg.kt.jg'
<% } else { -%>
        - '*.pawon.co'
<% } -%>
      secret: '{{ .Values.meta.name }}-server-stg'

  hosts:
<% if (appBusinessUnit === 'kitabisa' && appDeploy === 'gke-private') { -%>
    - host: '{{ if eq .Values.meta.env "stg" }}<%=appName%>-dashboard.stg.kt.bs{{ else }}{{ .Values.meta.env }}-<%=appName%>-dashboard.stg.kt.bs{{ end }}'
<% } else if (appBusinessUnit === 'kitajaga' && appDeploy === 'gke-private') { -%>
    - host: '{{ if eq .Values.meta.env "stg" }}<%=appName%>-dashboard.stg.kt.jg{{ else }}{{ .Values.meta.env }}-<%=appName%>-dashboard.stg.kt.jg{{ end }}'
<% } else { -%>
    - host: '{{ if eq .Values.meta.env "stg" }}<%=appName%>-dashboard.pawon.co{{ else }}{{ .Values.meta.env }}-<%=appName%>-dashboard.pawon.co{{ end }}'
<% } -%>
      paths:
        - '/'

autoscaling:
  minReplicas: 1
  maxReplicas: 1
