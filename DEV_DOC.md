# Mariadb

1. install the container from docker.io

```
docker pull maria:10.6
```

2. create a database from the pulled container

```
docker run --name mariadbtest -e MYSQL_ROOT_PASSWORD=mypass -p 3306:3360 -d docker.io/library/mariadb:10.6 --log-bin --binlog-format=MIXED
```

- `--name mariadbtest` : create container with name `mariadbtest`
- `-e MYSQL_ROOT_PASSWORD=mypass` : add an environment variable to the created container (required) 
- `-p 3306:3306` : expose a port between the container and the host device `<host>:<container>` 
- `-d` : make the container run in the background (detached mode) 
- `docker.io/library/mariadb:10.6` : specify the container to be pulled from docker.io




# Secrets : 

- Secrets are mounted as a file in `/run/secrets/<secret_name>` inside the container.
- Secrets should be made available in th build time

## Example : 

- for single service : 
```yml
services:
  myapp:
    image: myapp:latest
    secrets:
      - my_secret
secrets:
  my_secret:
    file: ./my_secret.txt
```

- for Multi-service

```yml
services:
   db:
     image: mysql:latest
     volumes:
       - db_data:/var/lib/mysql
     environment:
       MYSQL_ROOT_PASSWORD_FILE: /run/secrets/db_root_password
       MYSQL_DATABASE: wordpress
       MYSQL_USER: wordpress
       MYSQL_PASSWORD_FILE: /run/secrets/db_password
     secrets:
       - db_root_password
       - db_password

   wordpress:
     depends_on:
       - db
     image: wordpress:latest
     ports:
       - "8000:80"
     environment:
       WORDPRESS_DB_HOST: db:3306
       WORDPRESS_DB_USER: wordpress
       WORDPRESS_DB_PASSWORD_FILE: /run/secrets/db_password
     secrets:
       - db_password


secrets: # secrets top-level (shared between services) 
   db_password:
     file: db_password.txt
   db_root_password:
     file: db_root_password.txt

volumes:
    db_data:
```

# .env file 

to use the `.env` file 

```
services:
  webapp:
    env_file: "webapp.env"
```


# docker secret 
To pass a secret to a build, use the docker build --secret flag.
```sh
 docker build --secret id=aws,src=$HOME/.aws/credentials .
```

To consume a secret in a build and make it accessible to the RUN instruction, use the --mount=type=secret flag in the Dockerfile.

```sh
RUN --mount=type=secret,id=aws \
    AWS_SHARED_CREDENTIALS_FILE=/run/secrets/aws \
    aws s3 cp ...
```

# Nginx 

1- create a TLS private key and certificate

```sh
cd conf/ssl && 
openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout mmoulati.42.fr.key \
  -out mmoulati.42.fr.crt

```

# Volume 
- nginx and wordpress should be point to the same volume at the same path to make the configuration simple 
