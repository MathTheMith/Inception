NAME = inception

all:
	sudo mkdir -p /home/mvachon/data/wordpress /home/mvachon/data/mariadb
	docker compose -f srcs/docker-compose.yml up --build -d

down:
	docker compose -f srcs/docker-compose.yml down -v

clean: down

fclean: down
	docker system prune -a --volumes -f
	sudo rm -rf /home/mvachon/data

re: fclean all

.PHONY: all down clean fclean re
