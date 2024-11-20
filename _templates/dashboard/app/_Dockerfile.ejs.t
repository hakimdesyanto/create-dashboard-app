---
to: "<%= appDeploy.startsWith('gke') ? `apps/${appName}/Dockerfile` : null %>"
---
FROM nginxinc/nginx-unprivileged:1.26-alpine
COPY out /usr/share/nginx/html

#rewrite default nginx config
RUN rm -rf /etc/nginx/conf.d/*
RUN echo ' \
    server { \
        listen 8080; \
        root /usr/share/nginx/html; \
        location / { \
            try_files $uri $uri.html $uri/ =404; \
        } \
        error_page 404 /404.html; \
        location = /404.html { \
            internal; \
        } \
    } \
' > /etc/nginx/conf.d/default.conf
