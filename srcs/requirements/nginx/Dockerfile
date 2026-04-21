FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl
RUN openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/certs/nginx.crt -keyout /etc/ssl/private/nginx.key -subj "/CN=mvachon.42.fr"

COPY conf/nginx.conf /etc/nginx/conf.d

CMD ["nginx", "-g", "daemon off;"]