#flags
COMPOSE_FLAGS = -f ./srcs/docker-compose.yml

#commands
COMPOSE = docker compose $(COMPOSE_FLAGS) 

#dirs 
VOLUMES = /home/mmoulati/data/db /home/mmoulati/data/wp

#files 
ENV_FILE= srcs/.env

all: $(VOLUMES) domain 
	$(COMPOSE) up --build

verify:
	$(COMPOSE) ps

$(VOLUMES) : 
	mkdir -p $(VOLUMES) 

domain : $(ENV_FILE)  
	echo "127.0.0.1 $(shell grep '^DOMAIN_NAME=' $(ENV_FILE) | cut -d= -f2)\n127.0.0.1 localhost" > /etc/hosts

down:
	-$(COMPOSE) down -v

clean: down
	-docker stop `docker ps -qa` 2> /dev/null;
	-docker rm `docker ps -qa` 2> /dev/null;
	-docker rmi -f `docker images -qa` 2> /dev/null;
	-docker volume rm `docker volume ls -q` 2> /dev/null;
	-docker network rm `docker network ls -q` 2>/dev/null

fclean : clean
	sudo rm -rf /home/mmoulati/data/

re : fclean all

restart: clean all
	

.PHONY : clean fclean all rebuild restart domain
