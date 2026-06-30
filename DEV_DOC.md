## Developer Documentation

### 1. Setup 

#### 1.1 Prerequisites
To set up the environment, ensure the following tools are installed:
- **Docker Engine** (v20.10+)
- **Docker Compose** (v2+)
- **Make**

#### 1.2 Configuration Files

##### `.env` File
1. Create a `.env` file in the `./srcs/` directory with the following structure:
```.env
DOMAIN_NAME=

MYSQL_USER=
MYSQL_USER_PASSWORD=
MYSQL_ROOT_PASSWORD=

WP_ADMIN=
WP_ADMIN_PASSWORD=
WP_ADMIN_MAIL=

WP_USER=
WP_USER_PASSWORD=
WP_USER_MAIL=

FTP_USER=
FTP_PASSWORD=
```
2. Fill in the required values for each variable.

---

### 2. Build and Launch the Project

To build and launch the project, use the provided `Makefile`:
1. From the root of the repository, run:
   ```bash
   make
   ```
2. This will:
   - Build all Docker images.
   - Create and start the containers.
   - Set up the required volumes and network.

---

### 3. Managing Containers and Volumes

#### 3.1 Starting the Project
To start the project:
```bash
make
```

#### 3.2 Stopping the Project
To stop all running containers:
```bash
make stop
```

#### 3.3 Cleaning Up
To remove all containers, images, and volumes:
```bash
make clean
```

---

### 4. Persistent Data

The following directories store persistent data:
- **MariaDB database files**: `/home/mmoulati/data/db`
- **WordPress files and uploaded content**: `/home/mmoulati/data/wp`

---

### 5. Additional Commands

#### Viewing Logs
To view logs for all services:
```bash
docker compose -f srcs/docker-compose.yml logs
```

#### Checking Service Health
To check the health of a service:
```bash
docker inspect <service-name>
```
Look for:
```json
"Health": {
    "Status": "healthy"
}
```