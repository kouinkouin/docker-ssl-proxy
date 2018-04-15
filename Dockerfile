FROM nginx:stable

ADD ./files/conf.d /etc/nginx/conf.d
ADD ./files/global /etc/nginx/global
ADD ./files/run.sh /usr/sbin/run

RUN mkdir /etc/nginx/sites && \
    chmod +x /usr/sbin/run

VOLUME /etc/nginx/sites

ENTRYPOINT ["run"]

CMD ["nginx", "-g", "daemon off;"]

