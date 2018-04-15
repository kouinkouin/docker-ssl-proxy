server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;

    server_name _DOMAIN_;

    error_log /var/log/nginx/_DOMAIN__error.log warn;
    access_log /var/log/nginx/_DOMAIN__access.log combined;

    include global/ssl.conf;
    ssl_certificate certs/live/_DOMAIN_/fullchain.pem;
    ssl_certificate_key certs/live/_DOMAIN_/privkey.pem;
    ssl_trusted_certificate certs/live/_DOMAIN_/fullchain.pem;

    proxy_set_header    Host $host;
    proxy_set_header    X-Real-IP       $remote_addr;
    proxy_set_header    X-Forwarded-For $remote_addr;
    proxy_set_header    X-Forwarded-Host $host;
    proxy_set_header    X-Forwarded-Proto https;
    proxy_set_header    X-Forwarded-Port $server_port;

    location / {
        proxy_pass http://_WEBSERVER_;
    }
}

