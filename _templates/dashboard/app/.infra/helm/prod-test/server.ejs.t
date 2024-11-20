---
to: "<%= appDeploy.startsWith('gke') ? `.infra/helm/prod-test/server.yaml` : null %>"
---
server:
  enabled: true

  port: 8080

  resources:
    requests:
      cpu: 10m
      memory: 260Mi
    limits:
      memory: 520Mi

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
        - '<%=appName%>-dashboard.prod-test.kt.bs'
<% } else if (appBusinessUnit === 'kitajaga' && appDeploy === 'gke-private') { -%>
        - '<%=appName%>-dashboard.prod-test.kt.jg'
<% } else { -%>
        - '<%=appName%>-dashboard.pawon.us'
<% } -%>

  hosts:
<% if (appBusinessUnit === 'kitabisa' && appDeploy === 'gke-private') { -%>
    - host: '<%=appName%>-dashboard.prod-test.kt.bs'
<% } else if (appBusinessUnit === 'kitajaga' && appDeploy === 'gke-private') { -%>
    - host: '<%=appName%>-dashboard.prod-test.kt.jg'
<% } else { -%>
    - host: '<%=appName%>-dashboard.pawon.us'
<% } -%>
      paths:
        - '/'

autoscaling:
  minReplicas: 1
  maxReplicas: 1
