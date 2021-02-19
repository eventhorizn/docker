# Docker Bootcamp

## Getting Started

1. [Docker for Windows](https://docs.docker.com/docker-for-windows/install/)
1. Hello World
   ```cmd
   docker run hello-world
   ```
   - You don't have the hello-world image locally, so it reaches out to docker hub
     ![](images/docker-eco.png)
1. How does it work on a system?
   ![](images/docker-def.png)

   - EVERY image is running on a linux VM

# Docker CLI

## Simple Hello World

```ps
docker run hello-world
```

## Command Override

1. Definition
   ```
   docker run <image-name> <command>
   ```
1. Print
   ```
   docker run busybox echo hi there
   ```
1. Listing unix folders inside a container
   ```
   docker run busybox ls
   ```
   - The echo commands exist inside the busybox image
   - They do NOT exist in the hello-world image
1. Doesn't work
   ```
   docker run hello-world echo hi
   ```
   - Commands are limited by the image

## List All Images on Machine

1. Command
   ```
   docker ps
   ```
1. Busybox and hello-world are in general short running containers
1. This will keep busybox running
   ```
   docker run busybox ping google.com
   ```
   ```
   docker ps
   ```
   ![](images/docker-ps.png)
1. This is a good command to remember if you need to grab image ids

## List All Images Ever Created

1. Command
   ```
   docker ps --all
   ```
1. Which introduces the idea of a container life cycle
   - When does a container get shut down
   - Why does a container get shut down
   - What happens when it does

**docker run = docker create + docker start**

## Docker Create and Docker Start

1. Docker Create
   ```
   docker create hello-world
   ```
1. You'll get a long string like so:
   ```
   f7b241874c91443af5c22f3f4fd3de79e397ce4118c9c2d532d80adb33039cc9
   ```
   - Container id
1. Docker Start
   ```
   docker start -a f7b241874c91443af5c22f3f4fd3de79e397ce4118c9c2d532d80adb33039cc9
   ```
   - What does the `-a` get you?
   - Makes docker wait for output and prints it out to terminal
   - Docker start will not show you output by default
1. Restart a container
   ```
   docker run busybox echo hi there
   ```
   ```
   docker ps --all
   ```
   - Grab the id
   ```
   docker start -a <id>
   ```
   - You'll notice it showed 'hi t here'
   - You cannot replace the default command of a container once it's created
   - Can only start it and it will run that default command

## Clear Downloaded Containers

1. Show all containers
   ```
   docker ps --all
   ```
1. Remove all
   ```
   Docker system prune
   ```
1. Deletes cache as well as downloaded images
   - Will need to be re-cached (takes some time)

## Retrieving Log Outputs

1. Command
   ```
   docker logs <id>
   ```
1. Creating container to get logs
   ```
   docker create busybox echo hi there
   ```
   - Get the id
   ```
   docker start <id>
   ```
   ```
   docker logs <id>
   ```
1. Getting logs does NOT re-run the container
   - Simply gets all the logs emtted by the container
   - Much faster than re-running

## Stopping Containers

1. Create long running container
   ```
   docker create busybox ping google.com
   ```
   ```
   docker start <id>
   ```
1. See running image
   ```
   docker ps
   ```
1. So how do we stop this container?
1. Docker stop
   ```
   docker stop <id>
   ```
   - Gives the container 10 seconds to gracefully stop
1. Docker kill
   ```
   docker kill <id>
   ```
   - Shut down right now, no cleanup

## Multi Command Containers

1. The idea is that you will run containers that will have cli's within them
   - Servers, databases, etc
1. Redis is a server w/ it's own cli
   - You can run redis specific commands
1. Can we run this redis specific commands on a redis container?
   ```
   docker run redis
   ```
   - Eventually should see: `* Ready to accept connections`
1. How do we run commands in a container?
   ```
   docker exec -it <id> <command>
   ```
1. In a new terminal window
   ```
   docker exec -it <id> redis-cli
   ```
1. What is the `-it` flag
   - Two flags really, `-i` and `-t`
   - `-i` ties terminal to STDIN of image
   - `-t` makes input and output easy to read and gives 'intellisense'

## Getting Command Prompt In Container

1. Open a shell in a context of a container
   ```
   docker exec -it <id> sh
   ```
1. ctrl-c or ctrl-d to exit
   - I've found that ctrl-c does not kill the shell
1. Starting w/ a shell
   ```
   docker run -it busybox sh
   ```
