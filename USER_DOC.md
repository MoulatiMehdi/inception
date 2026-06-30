## User Documentation

### 1. Services Provided

This stack provides the following services:
- **WordPress**: A CMS for creating and managing websites.
- **MariaDB**: A database backend for WordPress.
- **NGINX**: A web server and reverse proxy.
- **FTP**: For file management.

#### Bonus Services:
- **Redis**: A caching service to improve WordPress performance.
- **Adminer**: A lightweight database management tool for MariaDB.
- **cAdvisor**: A monitoring tool for viewing container resource usage and performance metrics.
- **Static Website**: A simple static website hosted alongside the WordPress site.

---

### 2. Starting and Stopping the Project

#### Starting the Project
Run the following command:
```bash
make
```

#### Stopping the Project
To stop all running containers:
```bash
make down
```

---

### 3. Accessing the Services

#### Website
- Open your browser and navigate to `http://<DOMAIN_NAME>`.

#### WordPress Admin Panel
- URL: `http://<DOMAIN_NAME>/wp-admin`
- Credentials: Use the values from the `.env` file (`WP_ADMIN`, `WP_ADMIN_PASSWORD`).

#### FTP
- Host: `<DOMAIN_NAME>`
- Credentials: Use the values from the `.env` file (`FTP_USER`, `FTP_PASSWORD`).

#### Adminer (Bonus)
- URL: `http://<DOMAIN_NAME>/adminer`
- Use the MariaDB credentials from the `.env` file (`MYSQL_USER`, `MYSQL_USER_PASSWORD`).

#### Static Website (Bonus)
- URL: `http://<DOMAIN_NAME>/static`
- This is a simple static website hosted on the same NGINX server.

#### cAdvisor (Bonus)
- URL: `http://<DOMAIN_NAME>:8080`
- Use this tool to monitor container resource usage, including CPU, memory, and network statistics.

---

### 4. Managing Credentials

All credentials are stored in the `.env` file located in the `./srcs/` directory. Ensure this file is properly configured before starting the project.

---

### 5. Checking Service Health

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

---

### 6. Bonus Service: Redis

#### What is Redis?
Redis is an in-memory data structure store used as a caching layer to improve WordPress performance by reducing database queries.

#### How to Enable Redis Caching:
1. Install the **Redis Object Cache** plugin in WordPress.
2. Activate the plugin and configure it to connect to the Redis service.

#### Redis Connection Details:
- Host: `redis`
- Port: `6379`

---

### 7. Notes for Users

- Ensure that the `.env` file is properly configured before starting the project.
- Use the `make` commands to simplify starting, stopping, and cleaning up the project.
- For troubleshooting, check the logs of individual services:
  ```bash
  docker compose logs <service-name>
  ```