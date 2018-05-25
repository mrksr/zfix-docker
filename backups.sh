#!/bin/bash

BACKUP_FOLDER=${ZFIX_DB_BACKUP_FOLDER:-/srv/backup}

# Postgres
for container_id in $( docker ps --filter ancestor=postgres --filter ancestor=postgres:alpine --format {{.ID}} ); do
    container_name=$(docker ps --filter ID=$container_id --format {{.Names}})
    docker exec $container_id bash -c "\
        PGPASSWORD=postgres pg_dumpall -U postgres \
        " | xz > $BACKUP_FOLDER/postgres_${container_name}_latest.sql.xz
done

# MariaDB
for container_id in $( docker ps --filter ancestor=mariadb --format {{.ID}} ); do
    container_name=$(docker ps --filter ID=$container_id --format {{.Names}})
    docker exec $container_id bash -c "\
        mysqldump --all-databases --triggers --routines --events \
        -uroot -pstellarlyunbreakablekey \
        --single-transaction \
        --flush-logs --flush-privileges
        " | xz > $BACKUP_FOLDER/mariadb_${container_name}_latest.sql.xz
done

# Docker volumes
for volume_id in $( docker volume ls -q ); do
    # We do not backup 'unnamed' docker volumes
    if [[ ! $volume_id =~ [0-9a-fA-F]{60} ]]; then
        docker run \
            -v ${volume_id}:/volume \
            -v ${BACKUP_FOLDER}:/backup \
            --rm \
            loomchild/volume-backup \
            backup volume_$volume_id
    fi
done
