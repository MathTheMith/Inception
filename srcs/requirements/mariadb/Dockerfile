FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server

COPY --chmod=755 conf/init.sh /tmp

CMD ["sh", "/tmp/init.sh"]

