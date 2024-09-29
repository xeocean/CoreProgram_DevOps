FROM nginx

COPY ./fastcgi_server.c .
COPY ./start_server.sh .
COPY ./nginx.conf /etc/nginx/nginx.conf

RUN apt update && apt install -y gcc spawn-fcgi libfcgi-dev && \
    rm -rf /var/lib/apt/lists/*; \
    useradd server_user; \
    chown -R server_user: /etc/nginx/nginx.conf; \
    chown -R server_user: /var/cache/nginx; \
    touch /var/run/nginx.pid && chown -R server_user: /var/run/nginx.pid; \
    gcc ./fastcgi_server.c -lfcgi -o fcgi_server

USER server_user
    
HEALTHCHECK CMD curl --fail http://localhost || exit 1

ENTRYPOINT ["bash", "./start_server.sh"]
