#flags
COMPOSE_FLAGS = -f ./srcs/docker-compose.yml

#commands
COMPOSE = docker compose $(COMPOSE_FLAGS) 

#dirs 
VOLUMES = /home/mmoulati/data

#files 
ENV_FILE= srcs/.env

all: $(VOLUMES) domain 
	- $(COMPOSE) up --build

$(VOLUMES) : 
	- mkdir -p $(VOLUMES) 

domain : $(ENV_FILE) 

	DOMAIN=$(shell grep '^DOMAIN_NAME=' "${ENV_FILE}" | cut -d= -f2)
	sudo sed -i "/127.0.0.1/d" /etc/hosts
	echo "127.0.0.1 $(DOMAIN)" | sudo tee -a /etc/hosts
	echo "127.0.0.1 localhost" | sudo tee -a /etc/hosts

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

rebuild : fclean all

restart: clean all
	

.PHONY : clean fclean all rebuild restart db-sh wp-sh nginx-sh dir alpine domain
