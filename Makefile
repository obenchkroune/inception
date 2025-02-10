DCFLAGS	:=	-f ./srcs/docker-compose.yml

up:
	mkdir -p /home/obenchkr/data/web /home/obenchkr/data/db
	docker compose $(DCFLAGS) up --build -d

down:
	docker compose $(DCFLAGS) down

clean: down
	@(docker stop $(shell docker ps -qa); docker rm $(shell docker ps -qa); docker rmi -f $(shell docker images -qa); docker volume rm $(shell docker volume ls -q); docker network rm $(shell docker network ls -q); exit 0) 2>/dev/null

fclean: clean
	docker system prune -a --volumes -f

re: clean up

.PHONY: up down clean fclean re
