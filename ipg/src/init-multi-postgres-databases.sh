# INSPIRED BY https://github.com/mrts/docker-postgresql-multiple-databases
# Get there for improvments
# At launch of PG service, if the data folder is empty, the SSH scripts in the /docker-entrypoint-initdb.d/ folder are executed.
# So add this line in the docker compose file :  - ./src/init-multi-postgres-databases.sh:/docker-entrypoint-initdb.d/init-multi-postgres-databases.sh, in "volumes" part.

#!/bin/bash

# Clean previous commands with unfinished status
set -e
set -u

# 
function create_databases() {
    database=$1
    password=$2
    echo "Creating user and database '$database' with password '$password'"
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
      CREATE USER $database with encrypted password '$password';
      CREATE DATABASE $database OWNER $database;
EOSQL
}


if [ -n "$POSTGRES_MULTIPLE_DATABASES" ]; then
  echo "Multiple database creation prompt: $POSTGRES_MULTIPLE_DATABASES"
  for db in $(echo $POSTGRES_MULTIPLE_DATABASES | tr ',' ' 'h); do
    user=$(echo $db | awk -F":" '{print $1}')
    pswd=$(echo $db | awk -F":" '{print $2}')
    if [[ -z "$pswd" ]]
    then
      pswd=$user
    fi
    create_databases $user $pswd
  done
  echo "Databases successfully created."
fi