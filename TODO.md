# TODO 

- on crash the container should restart
- must use alpine or debian 
- each docker image must have the same name as its corresponding service 
- you have to write your own `Dockerfiles` one pepr service. 
- `Dockerfiles` must be called in your `docker-compose.yml` by your makefile 
## Containers : 

### Nginx :

- `Nginx`
- `TLSv1.2` or `TLSv1.3` 
- link the wordpress volume to it
- expose the port 443 to access the page

### wordpress :
- `WordPress`
- `php-fpm`
- link the wordpress volume to it

- there must be two users one of them being the administrator. The administrator’s username can’t contain admin/Admin and so forth).

### database :
- `MariaDB`
- link the volume of the database to it

## Volumes : 
(must be a named volumes and store their data inside the `/home/<login>/data`)
- for wordpress database 
- for wordpress files


## Network : 
    a docker-network that establishes the connection between your containers
             443             9000                3306
     WWW    <---->  Nginx   <---->  Wordpress   <---->  DB





# Prohibited : 

## DockerFile

- The latest tag is prohibited.
- No password must be present in your Dockerfiles.
- It is mandatory to use environment variables.
- it is mandatory to use a .env file to store environment variables.
- It is strongly recommended that you use Docker secrets to store any confidential information.
- Any credentials, API keys,or passwords found in your Git repository (outside of properly configured secrets) will result in project failure.

- using network: host or --link or links: is forbidden.
- The network line must be present in your docker-compose.yml file.
- Your containers must not be started with a command running an infinite loop.
- the following are a few prohibited hacky patches: tail -f, bash, sleep infinity, while true.

## NGINX
- Your NGINX container must be the only entrypoint into your infrastructure via the port 443 only, using the TLSv1.2 or TLSv1.3 protocol.
