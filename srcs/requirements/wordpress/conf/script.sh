#!/bin/bash
set -e 

mkdir -p /run/php

sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/8.2/fpm/pool.d/www.conf

until bash -c 'echo > /dev/tcp/127.17.0.1/3306' 2>/dev/null; do
    echo "Waiting for MariaDB..."
    sleep 1
done

if [ ! -f /srv/www/wordpress/wp-config.php ]; then
    wp config create \
        --path=/srv/www/wordpress \
        --dbname=wp-database \
        --dbuser=wp-user \
        --dbpass=wp-pass \
        --dbhost=127.17.0.1 \
        --skip-check \
        --alow-root
    chown -R www-data:www-data /srv/www/wordpress
fi

exec php-fpm8.2 -F