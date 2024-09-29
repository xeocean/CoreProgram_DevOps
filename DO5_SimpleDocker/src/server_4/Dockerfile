FROM nginx

COPY ./fastcgi_server.c .
COPY ./start_server.sh .
COPY ./nginx.conf /etc/nginx/nginx.conf

RUN apt update && apt install -y gcc spawn-fcgi libfcgi-dev

ENTRYPOINT ["bash", "./start_server.sh"]
