#!/bin/bash
mkdir -p ./backups
docker exec -it oj-mongo mongodump -o /mongo-bak
docker cp oj-mongo:/mongo-bak ./backups
tar -zcf ./backups/mongodb-backup-$(date "+%Y_%m_%d_%H_%M").tar.gz ./backups/mongo-bak
rm -rf ./backups/mongo-bak
