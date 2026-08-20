FROM debian:12

RUN apt-get update && apt-get install -y \
    php-fpm php-cli php-mysql php-curl php-gd \
    php-gd php-intl php-mbstring php-xml php-zip curl \
    && curl -f https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
        -o /usr/local/bin/wp && chmod +x /usr/local/bin/wp

COPY conf/script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

ENTRYPOINT ["script.sh"]