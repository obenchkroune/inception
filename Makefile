DCFLAGS	:=	-f ./srcs/docker-compose.yml

up:
	docker compose $(DCFLAGS) up --build -d

down:
	docker compose $(DCFLAGS) down

clean: down
	docker stop $(shell docker ps -qa); docker rm $(shell docker ps -qa); docker rmi -f $(shell docker images -qa); docker volume rm $(shell docker volume ls -q); docker network rm $(shell docker network ls -q)
	@echo "OK"

fclean: clean
	for i in $(shell docker volume ls -q); do docker volume rm "$i"; done;

re: fclean up

.PHONY: up down clean fclean re
