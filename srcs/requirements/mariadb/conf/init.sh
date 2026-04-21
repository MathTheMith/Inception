#!/bin/sh

if [ -z "$MYSQL_DATABASE" ]; then
  echo "Nothing found for MYSQL_DATABASE"
fi

if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
  echo "Nothing found for MYSQL_ROOT_PASSWORD"
fi

if [ -z "$MYSQL_USER" ]; then
  echo "Nothing found for MYSQL_USER"
fi

if [ -z "$MYSQL_PASSWORD" ]; then
  echo "Nothing found for MYSQL_PASSWORD"
fi

mkdir -p /run/mysqld 
chown mysql:mysql /run/mysqld
mysqld &

RETRIES=30

while ! mysqladmin -u root -p$MYSQL_ROOT_PASSWORD ping > /dev/null 2>&1; do
  RETRIES=$((RETRIES - 1))
  if [ $RETRIES -eq 0 ]; then
      echo "Mariadb not reachable, exiting"
      exit 1;
  fi
  sleep 2
done

echo "MySQL OK !"

mysql -uroot -p${MYSQL_ROOT_PASSWORD} -h localhost -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
echo "Database successfully created!"
echo "Showing existing databases..."
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -h localhost -e "show databases;"
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -h localhost -e "CREATE USER IF NOT EXISTS ${MYSQL_USER}@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
echo "Granting ALL privileges on ${MYSQL_DATABASE} to ${MYSQL_USER}!"
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -h localhost -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -h localhost -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown
exec mysqld --bind-address=0.0.0.0 
