#!/bin/bash

BACKUP_FOLDER=${ZFIX_DB_BACKUP_FOLDER:-/srv/backup}

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
