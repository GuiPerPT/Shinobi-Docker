# Shinobi Docker

## Getting Started
### TO RUN ( This docker image was developed to work with Mysql container and share files with host)
If you run like this after a container restart you will not be able to connect to mysql database.
docker run -p 8080:8080 ulisses1478/shinobi

### Installing

#### If you want to make you will need to run a command manually inside it and setup and copy files to host machine (Don't forget if you do you can lost all your files).

#### This will make your install without permanent files and database (but is required if you want to make permanent files)
First you run
```
docker run -p 8080:8080 ulisses1478/shinobi
```
Then access the docker bash
```
docker run -p 8080:8080 ulisses1478/shinobi
docker exec -it <CONTAINER_ID> bash
```
And install the shinobi
```
cd /shinobi && INSTALL/ubuntu.sh
```
Then copy all files from the container to the host machine
```
docker cp <CONTAINER_ID>:/shinobi /host/path/target
```
Delete the docker container and change conf.json inside shinobi the path you just copied to the host machine to you mysql config
```
docker container rm <CONTAINER_ID>
docker cp <CONTAINER_ID>:/shinobi /host/path/target
```
This will start your shinobi container
```
docker run -d --name='Shinobi' -p '8080:8080/tcp' -v '/host/path/target':'/shinobi':'rw' -v '/host/videos/path/target':'/shinobi/videos':'rw' 'ulisses1478/shinobi' 
```
## Now you should be able to access web UI over port 8080 
## Authors

* **Ulisses** - *Full work* - [Ulisses1478](https://github.com/ulisses1478)

