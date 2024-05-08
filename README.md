# base-containers
Some base docker containers, the simplest is the better. Call it with Docker compose on a Debian 12 instance.
## Folder structure
├── Root folder
<br>│   ├── ipg
<br>│   │    │  docker-compose.yml
<br>│   │    │  .env
<br>│   │    ├── src
<br>│   │    │    init-multi-postgres-databases.ssh
<br>│   │    ├── data
<br>│   ├── inginx
<br>│   │    │  docker-compose.yml
<br>│   │    │  .env
<br>│   │    ├── data
<br>│   │    ├── conf
<br>│   │    │    │ *.conf
<br>│   │    ├── certbot
<br>│   │    │    │  docker-compose.yml
<br>│   │    │    ├── conf
<br>│   │    │    ├── www
<br>│   ├── keycloak
<br>│   │    │  docker-compose.yml
<br>│   │    │  .env
<br>│   │    ├── data
<br>│   ├── hedgedoc
<br>│   │    │  docker-compose.yml
<br>│   │    │  .env
<br>│   │    ├── upload

This structure MUST be kept, otherwise you'll need to update all the volumes assignation in docker-compose files.
## Some explanation
The developer chose to separate docker-compose between folders, with .env separated, to allow the build of services one by one and to prevent files being oerwritten by mistake.
## Let's go
The first docker you need to build is iPg and siblings. Go to ipg and build it.
``` ssh
cd ipg
docker-compose -up -d
```
Then launch inginx service.
``` ssh
cd ..
cd inginx
docker-compose -up -d
```
And finally the Keycloak service.
``` ssh
cd ..
cd ikeycloak
docker-compose -up -d
```
Then you're ready to go in each folder to launch your apps.
