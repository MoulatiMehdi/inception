COMPOSE_FLAGS = -f ./srcs/docker-compose.yml
COMPOSE = docker compose $(COMPOSE_FLAGS) 



all: dir 
	- $(COMPOSE) up --build
dir : 
	- mkdir -p /home/mmoulati/data/db /home/mmoulati/data/wp 

alpine: 
	-docker run -it alpine:3.23 /bin/sh 

wp-sh : 
	-$(COMPOSE) exec wordpress /bin/sh 
db-sh : 
	-$(COMPOSE) exec mariadb /bin/sh 
nginx-sh:
	-$(COMPOSE) exec nginx /bin/sh 


clean:
	-$(COMPOSE) down -v
fclean : clean
	-docker stop `docker ps -qa` 2> /dev/null;
	-docker rm `docker ps -qa` 2> /dev/null;
	-docker rmi -f `docker images -qa` 2> /dev/null;
	-docker volume rm `docker volume ls -q` 2> /dev/null;
	-docker network rm `docker network ls -q` 2>/dev/null
	-docker builder prune -f

rebuild : fclean all

restart: clean all
	

.PHONY : clean fclean all rebuild restart db-sh wp-sh nginx-sh dir alpine
