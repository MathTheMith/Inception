#!/bin/sh

set -e

RETRIES=30

while ! mysqladmin -u $MYSQL_USER -p$MYSQL_PASSWORD ping -h mariadb 2>&1; do
    RETRIES=$((RETRIES - 1))
    if [ $RETRIES -eq 0 ]; then
        echo "Wordpress not reachable, exiting"
        exit 1;
    fi
  sleep 2
done

cd /var/www/html
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

if [ ! -f /var/www/html/wp-config.php ];
then
    wp --allow-root core download --locale="$LOCALE" --force
    wp --allow-root config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --dbhost="$MYSQL_HOST" --locale="$LOCALE"
    wp --allow-root core install --url="$SITE_URL" --title="$SITE_TITLE" --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASS" --admin_email="$ADMIN_EMAIL"
    wp --allow-root rewrite structure '/%postname%/' --hard
    wp --allow-root rewrite flush --hard
    wp --allow-root user create $BASIC_USER $USER_MAIL --role=editor --user_pass=$USER_PASS
    set +e
    wp --allow-root plugin delete hello akismet
    set -e

    ACCUEIL_ID=$(wp --allow-root post create --post_type=page --post_title="Accueil" --post_status=publish --porcelain)

    wp --allow-root option update show_on_front page
    wp --allow-root option update page_on_front "$ACCUEIL_ID"
fi
mkdir -p /run/php
exec php-fpm7.4 -F
