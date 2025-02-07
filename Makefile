DCFLAGS	:=	-f ./srcs/docker-compose.yml

up:
	docker compose $(DCFLAGS) up --build -d

down:
	docker compose $(DCFLAGS) down

clean: down
	docker rm $(shell docker ps -aq)
	docker rmi $(shell docker images -aq)
	docker network prune -f
	docker volume prune -f
	docker builder prune -f

fclean:
	docker system prune -a --volumes

.PHONY: up down clean fclean
