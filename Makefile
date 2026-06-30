#flags
COMPOSE_FLAGS = -f ./srcs/docker-compose.yml

#commands
COMPOSE = docker compose $(COMPOSE_FLAGS) 

#dirs 
VOLUMES = /home/mmoulati/data/db /home/mmoulati/data/wp

#files 
ENV_FILE= srcs/.env

up: $(VOLUMES) domain 
	$(COMPOSE) up --build

ps:
	$(COMPOSE) ps

$(VOLUMES) : 
	mkdir -p $(VOLUMES) 

domain : $(ENV_FILE)  
	echo "127.0.0.1 $(shell grep '^DOMAIN_NAME=' $(ENV_FILE) | cut -d= -f2)\n127.0.0.1 localhost" > /etc/hosts

down:
	-$(COMPOSE) down

clean: down
	-docker stop `docker ps -qa` 2> /dev/null;
	-docker rm `docker ps -qa` 2> /dev/null;
	-docker rmi -f `docker images -qa` 2> /dev/null;
	-docker volume rm `docker volume ls -q` 2> /dev/null;
	-docker network rm `docker network ls -q` 2>/dev/null

fclean : clean
	sudo rm -rf /home/mmoulati/data/

re : fclean up

restart: clean up
	

.PHONY : clean fclean up rebuild restart domain
