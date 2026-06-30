*This project has been created as part of the 42 curriculum by `mmoulati`.*

## 1. Table of Content 
- [1. Table of Content](#1-table-of-content)
- [2. Description](#2-description)
- [3. Instructions](#3-instructions)
  - [3.1. Installation \& Execution](#31-installation--execution)
- [4. Resources](#4-resources)
  - [4.1. Docker](#41-docker)
  - [4.2. Alpine](#42-alpine)
  - [4.3. Mariadb](#43-mariadb)
- [5. AI Usage](#5-ai-usage)
- [6. Project description](#6-project-description)
  - [6.1. Main Design Choices](#61-main-design-choices)
  - [6.2. Virtual Machine vs Docker](#62-virtual-machine-vs-docker)
  - [6.3. Secrets vs Environment Variables](#63-secrets-vs-environment-variables)
  - [6.4. Docker Network vs Host Network](#64-docker-network-vs-host-network)
  - [6.5. Docker Volumes vs Bind Mounts](#65-docker-volumes-vs-bind-mounts)

## 2. Description

Inception is a System Administration project from the 42 curriculum that introduces containerization using Docker.

The goal is to build a complete web infrastructure composed of multiple isolated services, each running inside its own Docker container.

Unlike using prebuilt images, every service is built from a custom Dockerfile, providing complete control over the installation and configuration process.

The mandatory infrastructure consists of:

- NGINX (TLS 1.2/1.3)
- WordPress with PHP-FPM
- MariaDB
- Docker network
- Docker named volumes

The services communicate through a dedicated Docker network while exposing only the HTTPS endpoint to the host machine.


## 3. Instructions

### 3.1. Installation & Execution

1. Clone the repository
```sh
git clone https://github.com/MoulatiMehdi/inception.git
```

2. Enter the folder and launch it
```sh
cd inception
make
```


## 4. Resources
### 4.1. Docker
- [Docker Engine Installation](https://docs.docker.com/engine/install/ubuntu/)
- [Docker Compose Documentation](https://docs.docker.com/engine/install/ubuntu/)
### 4.2. Alpine
- [Alpine Wiki - Mariadb](wiki.alpinelinux.org/wiki/MariaDB)
- [Alpine Wiki - Nginx](https://wiki.alpinelinux.org/wiki/Nginx)
- [Alpine Wiki - Wordpress](https://wiki.alpinelinux.org/wiki/WordPress)
### 4.3. Mariadb
- [Mariadbd Docs : Options](https://mariadb.com/docs/server/server-management/starting-and-stopping-mariadb/mariadbd-options)
- [Mariadb Docker Image](https://github.com/MariaDB/mariadb-docker/blob/af9b72baa083d6c40b2e0741ec65fd74adacde68/12.3/Dockerfile)

## 5. AI Usage

AI was specifically used for:

- Understanding Docker concepts, including : 
     - images
     - containers
     - volumes
     - networks
     - Docker Compose.
- Learning how NGINX, PHP-FPM, MariaDB, and WordPress communicate within a containerized infrastructure.
- Explaining Linux commands, permissions, networking, and file system organization.
- Understanding TLS certificates and configuring HTTPS with NGINX.
- Reviewing Bash scripts and improving their readability and robustness.
- Troubleshooting Docker, Docker Compose, and service configuration issues.
- Clarifying Docker best practices, such as using one process per container, environment variables, Docker secrets, and persistent storage.
- Writing and improving project documentation (README, USER_DOC, and DEV_DOC).


## 6. Project description

### 6.1. Main Design Choices

The following design decisions were made while implementing the project:

- One service per container to improve modularity, maintainability, and fault isolation.

- Custom Docker images built from Dockerfiles instead of using prebuilt application images.
- Alpine Linux as the base image to reduce image size and minimize the attack surface.
- NGINX as the only exposed service, ensuring that all external traffic passes through a single secure HTTPS endpoint.
- Docker named volumes to provide persistent storage for the WordPress files and MariaDB database.

- A dedicated Docker bridge network to allow secure communication between containers without exposing internal services.
- Environment variables for configuration as it required by the subject.

### 6.2. Virtual Machine vs Docker

|Virtual Machines|Docker|
| :---:        |    :----:   |
|Virtualize the hardware.|Virtualizes the operating system.|
|Include a complete guest operating system.|Share the host kernel.|
|Require more CPU, memory, and disk space.|Lightweight and resource-efficient.|
|Slower startup.| Starts almost instantly.|
|Better for running different operating systems.|Better for deploying applications and microservices.|


Docker is used in this project because it provides :
- lightweight isolation
- faster deployment
- lower resource consumption
- reproducible environments while maintaining good process isolation.

### 6.3. Secrets vs Environment Variables
|Docker Secrets|	Environment Variables|
|:----:|:----:|
|Intended for sensitive information such as passwords and private keys.|Intended for application configuration.|
|Stored securely outside the image.|	Passed directly to the container environment.|
|Less likely to be exposed accidentally.|	Can be viewed by processes running inside the container.|
|Recommended for production credentials.|	Suitable for non-sensitive configuration values.|

Environment variables are used as required by the subject. In real production environments, Docker Secrets would be preferred for sensitive credentials.

###  6.4. Docker Network vs Host Network


|Docker Bridge Network |	Host Network|
|:---:|:-----:| 
|Containers communicate through an isolated virtual network.|	Containers share the host's network stack.|
|Provides automatic DNS-based service discovery.|	No network isolation between host and containers.|
|Prevents unnecessary exposure of internal services.|	All container ports are directly exposed on the host.|
|Improves security and modularity.|	May lead to port conflicts and reduced isolation.|

A custom Docker bridge network ensures secure internal communication between services.

### 6.5. Docker Volumes vs Bind Mounts

|Docker Volumes	|Bind Mounts|
| :---: | :---: | 
|Managed entirely by Docker.|	Directly reference directories on the host.|
|Portable across environments.|	Depend on the host filesystem structure.|
|Recommended for persistent application data.|	Commonly used during development.|
|Better suited for databases and production workloads.|	Easier to accidentally modify or delete host files.|

Docker named volumes are used to persist the MariaDB database and WordPress files independently of the container lifecycle. This ensures that recreating containers does not result in data loss.