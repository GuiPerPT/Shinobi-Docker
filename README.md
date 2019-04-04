# Shinobi Docker

## Getting Started
### TO RUN ( This docker image was designed to work with Mysql container and share files with host) 
But you can run fine without it

#### If you run like this after a container restart you will not be able to connect to mysql database.
```
docker run -p 8080:8080 ulisses1478/shinobi
```
### Installing
#### Just run this command and now you should be able to access web UI over port 8080
```
docker run -p 8080:8080 ulisses1478/shinobi
```

#### If you want remove and and container later you will need to save the config files and the database so you need to run the docker like this

```
docker run -d --name='Shinobi' -p '8080:8080/tcp' -v '/host/path/target':'/shinobi':'rw' -v '/host/path/target':'/var/lib/mysql':'rw' -v '/host/videos/path/target':'/shinobi/videos':'rw' 'ulisses1478/shinobi' 
```
## Now you should be able to access web UI over port 8080 
## Authors

* **Ulisses** - * Docker work by* [Ulisses1478](https://github.com/ulisses1478)


