
# NOTES : 

## Cgroup

A cgroup is a Linux kernel mechanism that controls and limits how much system resources a group of processes can use.

What it manages:

- CPU usage
- Memory usage
- Disk I/O
- Number of processes
- Network bandwidth (in some setups)


## Namespaces

A namespace is a Linux kernel mechanism that:

isolates what a process can see.

What it isolates:

- Process IDs (PID namespace)
- Network interfaces (NET namespace)
- Mount points (MNT namespace)
- Hostname (UTS namespace)
- IPC objects
- Users (USER namespace)

## NGINX 

### TLS 
TLS encrypts data, verifies the server’s identity, and ensures the data is not modified during transmission between two systems over a network.


`/etc/nginx`     : your custom config (read-only inside container)
`/var/lib/nginx` : usually not important unless caching is enabled



## Wordpress 

`/var/www/html`  : WordPress files 

## Docker


### Docker Image

A Docker image is A read-only template that contains everything needed to run an application.

It includes:
- application binaries (e.g. nginx, node, python)
- shared libraries (glibc, openssl, etc.)
- configuration files
- minimal Linux directory structure (/bin, /etc, /usr, …)



### Docker File 

A Dockerfile is a text file that contains step-by-step instructions for assembling a Docker image.

It tells Docker:
- what base environment to start from
- what files to copy
- what dependencies to install
- what command to run when the container starts


A Docker image is the result of building a Dockerfile (for custom images).


### Docker Compose 

Docker Compose is a tool for defining and running multi-container applications using a single configuration file.


### Volumes : 


### Daemon
A daemon is a process that detaches from the terminal and continues running in the background.
Do not run your application as a traditional daemon inside the container. Run it in the foreground as PID 1.
Docker cannot properly:

- monitor the service
- restart it if it crashes
- forward signals correctly
- determine container health

Docker uses PID 1 to decide if the container still running. If PID 1 exits, container stops.
