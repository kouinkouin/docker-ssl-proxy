#!/bin/bash
set -e

SITES_DIR=/etc/nginx/sites

if [ ! -d $SITES_DIR ]; then
    echo "[error] $SITES_DIR does not exist, that's not a standard situation"
    exit 1
fi

if [ -v SSL_PROXY_SITES ]; then
    # SSL_PROCY_SITES="blog.kouinkouin.me,grav-web:80 ton-ip.net,ton-ip-web:80"
    for site in $SSL_PROXY_SITES; do
	echo "[info] site=$site"
	# site="blog.kouinkouin.me,grav-web:80"
	domain=$(echo "$site" | cut -d',' -f1)
	webserver=$(echo "$site" | cut -d',' -f2)
	echo "[info] domain=$domain ; webserver=$webserver"
	sed "s/_DOMAIN_/$domain/;s/_WEBSERVER_/$webserver/" /etc/nginx/conf.d/vhost.conf.tpl > $SITES_DIR/$domain.conf
    done
else
    echo "SSL_PROXY_SITES not defined"
fi

exec $@

