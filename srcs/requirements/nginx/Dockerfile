FROM debian:12

RUN apt-get update && apt-get install -y nginx openssl \
    && mkdir -p /etc/nginx/ssl && openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=MA/ST=SO/L=Agadir/O=1337/CN=aakroud.42.fr"

COPY conf/default.conf /etc/nginx/conf.d/default.conf


ENTRYPOINT ["nginx", "-g", ""]
