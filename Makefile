DOCKER_COMPOSE_PATH := ./srcs/docker-compose.yml

up:
	mkdir -p $(addprefix /home/obenchkr/data/, wordpress mariadb redis adminer)
	docker compose -f $(DOCKER_COMPOSE_PATH) up --build -d

down:
	docker compose -f $(DOCKER_COMPOSE_PATH) down

clean: down
	@(docker stop $(shell docker ps -qa); docker rm $(shell docker ps -qa); docker rmi -f $(shell docker images -qa); docker volume rm $(shell docker volume ls -q); docker network rm $(shell docker network ls -q); exit 0) 2>/dev/null

fclean: clean
	docker system prune -a --volumes -f

re: clean up

.PHONY: up down clean fclean re
