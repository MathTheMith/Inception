# Developer Documentation

## Prerequisites

- Docker and Docker Compose installed
- `sudo` access (required to create and delete data directories)
- The domain `mvachon.42.fr` must point to `127.0.0.1` in `/etc/hosts`

---

## Environment setup

### 1. Configure `/etc/hosts`

```sh
echo "127.0.0.1 mvachon.42.fr" | sudo tee -a /etc/hosts
```

### 2. Create the environment file

Create `srcs/.env` with the following variables:

```env
MYSQL_DATABASE=mariadb
MYSQL_USER=<db_user>
MYSQL_PASSWORD=<db_password>
MYSQL_ROOT_PASSWORD=<root_password>

SITE_URL=https://mvachon.42.fr
SITE_TITLE=Inception
LOCALE=fr_FR

ADMIN_USER=<admin_username>
ADMIN_PASS=<admin_password>
ADMIN_EMAIL=<admin_email>

BASIC_USER=<user_username>
USER_PASS=<user_password>
USER_MAIL=<user_email>
```

> `ADMIN_USER` must not contain `admin`, `Admin`, `administrator`, or `Administrator`.

---

## Build and launch

```sh
make        # Creates data directories, builds images, starts containers
make down   # Stops and removes containers (volumes and data preserved)
make clean  # Stops containers and removes Docker named volumes
make fclean # Full cleanup: containers, volumes, and /home/mvachon/data
make re     # fclean + all (full rebuild)
```

---

## Container management

```sh
docker ps                        # List running containers
docker logs <container>          # View container logs
docker exec -it <container> sh   # Open a shell inside a container
docker compose -f srcs/docker-compose.yml ps   # Status via compose
```

---

## Data persistence

| Data | Location on host |
|------|-----------------|
| WordPress files | `/home/mvachon/data/wordpress` |
| MariaDB database | `/home/mvachon/data/mariadb` |

Data is stored using Docker named volumes with `driver: local` and `o: bind`, which bind the named volumes to specific paths on the host machine.

Data survives `make down` and `make clean` (which removes the Docker volume reference but not the files). Only `make fclean` deletes the files on disk.

---

## Project structure

```
.
├── Makefile
├── srcs/
│   ├── .env
│   ├── docker-compose.yml
│   └── requirements/
│       ├── mariadb/
│       │   ├── Dockerfile
│       │   └── conf/init.sh
│       ├── wordpress/
│       │   ├── Dockerfile
│       │   └── conf/init.sh
│       └── nginx/
│           ├── Dockerfile
│           └── conf/nginx.conf
```
