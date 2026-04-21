# User Documentation

## Services provided

This stack runs three services:

| Service | Role |
|---------|------|
| NGINX | HTTPS reverse proxy, entry point on port 443 |
| WordPress + PHP-FPM | Website and administration panel |
| MariaDB | WordPress database |

---

## Start and stop the project

From the root of the repository:

```sh
make        # Build images and start all containers
make down   # Stop and remove containers (data is preserved)
make clean  # Stop containers and remove Docker volumes
make fclean # Full cleanup including data on disk
make re     # Full rebuild from scratch
```

---

## Access the website

- **Website:** https://mvachon.42.fr
- **Administration panel:** https://mvachon.42.fr/wp-admin

> The browser will show a security warning because the SSL certificate is self-signed. Accept the exception to continue.

---

## Credentials

All credentials are stored in `srcs/.env` at the root of the project.

| Variable | Description |
|----------|-------------|
| `ADMIN_USER` | WordPress administrator username |
| `ADMIN_PASS` | WordPress administrator password |
| `BASIC_USER` | WordPress regular user username |
| `USER_PASS` | WordPress regular user password |
| `MYSQL_USER` | Database user |
| `MYSQL_PASSWORD` | Database user password |
| `MYSQL_ROOT_PASSWORD` | Database root password |

---

## Check that services are running

```sh
docker ps
```

All three containers (`nginx`, `wordpress`, `mariadb`) should show status `Up`.

To view the logs of a specific service:

```sh
docker logs nginx
docker logs wordpress
docker logs mariadb
```
