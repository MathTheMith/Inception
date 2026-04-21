NAME = inception

all:
	sudo mkdir -p /home/mvachon/data/wordpress /home/mvachon/data/mariadb
	docker compose -f srcs/docker-compose.yml up --build

down:
	docker compose -f srcs/docker-compose.yml down

clean: down
	docker compose -f srcs/docker-compose.yml down -v

fclean: clean
	sudo rm -rf /home/mvachon/data

re: fclean all

.PHONY: all down clean fclean re
