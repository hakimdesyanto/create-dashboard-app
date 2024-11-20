---
to: .local/nginx/<%=appName%>-dashboard.pawon.local.conf
---
server {
    listen 80;
    server_name <%=appName%>-dashboard.pawon.local;
    return 301 https://<%=appName%>-dashboard.pawon.local$request_uri;
}

server {
    listen 443 ssl;
    http2 on;
    server_name <%=appName%>-dashboard.pawon.local;
    ssl_certificate certs/pawon.local.crt;
    ssl_certificate_key certs/pawon.local.key;

    location / {
        proxy_set_header  X-Forwarded-For $remote_addr;
        proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header  Host $http_host;
        proxy_set_header  X-NginX-Proxy true;
        proxy_pass        http://localhost:3000;
        proxy_redirect off;
    }

    location /_next/webpack-hmr {
        proxy_pass http://localhost:3000/_next/webpack-hmr;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   html;
    }
}
