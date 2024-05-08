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
<br>NB : You have to create your own .env files.
Each .env file may look like that :
``` YAML
PG_PWD=XXXXX
PGA_USER=XXXXX
PGA_PORT=5050
PG_MULTI="hedgedoc:XXXXX,nextcloud:XXXXX,keycloak:XXXXX"
SWAGGER_PORT=8082
PG_PWD=XXXX # for ipg, refers to the password you want to set ; for thers services refers to password defined in PG_MULTI
PG_USER=XXXXX # change it for each service
PG_PORT=5432
PG_HOST=iPg
PG_DB=hedgedoc
KC_USER=XXXX
KC_PWD=XXXX
KC_PORT=2020
PG_DB=XXXX # change it for each service
KC_USER=XXXX
HD_DOMAIN=hedgedoc
HD_PORT=3030
KC_REALM=mydomain.com
URL_DNS=mydomain.com
KC_DNS=keycloak
KC_SECRET=XXXX
KC_CLIENT=XXXX
MAIL_CERTBOT=user@user.com
WEB_DOMAIN=*.mydomain.com
```
## Some explanation
The developer chose to separate docker-compose between folders, with .env separated, to allow the build of services one by one and to prevent files being oerwritten by mistake.
## Let's go
The first docker you need to build is iPg and siblings. Go to ipg and build it.
Replace each .env at the root of the service folder.
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
