FROM debian:bullseye

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates php-fpm php-mysql php-curl php-gd php-mbstring php-xml curl default-mysql-client \
    && sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf 

COPY --chmod=755 conf/init.sh /tmp

CMD ["sh", "/tmp/init.sh"]
