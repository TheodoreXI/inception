#!/bin/bash

set -e

mariadb --skip-networking &
PID=$!

if ! kill -0 "$PID"; then
    echo "Mariadb failed"
    exit 1
fi

until mariadb -e "select 42"; do
    if ! kill -0 "$PID"; then
    echo "Mariadb failed"
    exit 1
    fi
    sleep 1
done

mariadb << 'END'
    CREATE DATABASE IF NOT EXISTS `wpdataset`;
    CREATE USER IF NOT EXISTS `wpuser`@`%` IDENTIFIED BY `wppass`;
    GRANT ALL PRIVILEGES ON `wpdataset`.* TO `wpuser`@`%`;
END
kill "$PID"

exec mariadb

