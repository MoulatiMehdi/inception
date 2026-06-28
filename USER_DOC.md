# USER_DOC.md

# User Documentation

This document explains how to use and administer the Inception infrastructure.

---

# 1. Services Provided by the Stack

The stack consists of the following services:

| Service | Description |
|----------|----------|
| NGINX | Reverse proxy and HTTPS web server. Provides access to WordPress. |
| WordPress | Content Management System (CMS) used to host the website. |
| MariaDB | Database server used by WordPress. |
| Redis | Object cache used by WordPress to improve performance. |
| FTP | File transfer service used to manage WordPress files. |
| Adminer | Web-based database administration interface. |
| cAdvisor | Container monitoring and resource usage dashboard. |
| Static Website | Additional custom web service provided as a bonus. |

---

# 2. Starting the Project

From the root of the repository:

```bash
make
```

---

# 3. Stopping the Project

Stop all running containers:

```bash
docker compose -f srcs/docker-compose.yml stop
```

To stop and remove volumes:

```bash
docker compose -f srcs/docker-compose.yml down -v
```

---

# 4. Accessing the Services

## WordPress Website

How to open wordpress site:

1. Open `https://mmoulati.42.fr` Or `https://localhost:8080`
1. Accept the browser warning for the self-signed TLS certificate.

---

## WordPress Administration Panel

1. Open `https://mmoulati.42.fr/wp-admin/`
1. Accept the browser warning for the self-signed TLS certificate.
1. Log in using the WordPress administrator account.

---

## Adminer

1. Open `http://localhost:8081`
1. Log in using the credentials in the .env file for MySQL

---

## FTP

1. Connect using an existing FTP client:

```sh 
ftp <ftpuser>@localhost
```
1.  insert the password for that user


---

## cAdvisor

1. Open `http://localhost:8081`

---

## Static Website

1. Open `http://localhost:3000`

---

# 5. Credentials Management

The project credentials are stored in: `srcs/.env`


---

# 6. Verifying Service Health

## Check Container Status

```bash
docker compose -f srcs/docker-compose.yml ps
```

---

## View Logs

Display logs for all services:

```bash
docker compose -f srcs/docker-compose.yml logs
```

Display logs for a specific service:

```bash
docker compose -f srcs/docker-compose.yml logs nginx
docker compose -f srcs/docker-compose.yml logs wordpress
docker compose -f srcs/docker-compose.yml logs mariadb
```

---

## Check Healthchecks

Inspect container status:

```bash
docker inspect mariadb
docker inspect wordpress
```

Look for:

```text
"Health": {
    "Status": "healthy"
}
```

---

## Verify WordPress

Open:

```text
https://localhost:8080
```

Verify that:

- The website loads successfully.
- Pages are accessible.
- Comments can be created.
- Administration access works.

---

## Verify MariaDB

Enter the container:

```bash
docker exec -it mariadb mariadb -u <user> -p
```

Verify that the WordPress database exists:

```sql
SHOW DATABASES;
```

---

## Verify Redis

Enter the Redis container:

```bash
docker exec -it redis redis-cli
```

Run:

```text
PING
```

Expected result:

```text
PONG
```

---

## Verify FTP

Connect using an FTP client and ensure:

- Authentication succeeds.
- Files can be uploaded.
- Files appear in the WordPress volume.

---

## Verify cAdvisor

Open:

```text
http://localhost:7000
```

Ensure that all containers are visible and resource statistics are displayed.

---

# 7. Persistent Data

The following directories store persistent data:

```text
/home/mmoulati/data/db
```

MariaDB database files.

```text
/home/mmoulati/data/wp
```

WordPress files and uploaded content.

Data stored in these locations remains available after container recreation and system reboot.

---
