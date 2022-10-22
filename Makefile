COMPOSE_FILE = ./srcs/docker-compose.yml

all: up

premake:
	mkdir -p /home/$(USER)/data/wordpress_vol
	mkdir -p /home/$(USER)/data/db_vol

up: premake
	docker-compose -f $(COMPOSE_FILE) up -d --build

clean:
	docker-compose -f $(COMPOSE_FILE) down
	docker stop `docker ps -qa`
	docker rm `docker ps -qa`
	docker rmi -f `docker images -qa`
	docker volume rm `docker volume ls -q`
	docker network rm `docker network ls -q`

fclean: clean
	rm -rf /home/$(USER)/data/wordpress_vol
	rm -rf /home/$(USER)/data/db_vol

.PHONY: all premake up clean fclean
