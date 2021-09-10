#!/bin/bash
#tar -zcvf ./backups/minio-backup-$(date "+%Y_%m_%d_%H_%M").tar.gz ./data/minio
tar cf - ./data/minio | pigz -9 -p 32 > ./backups/minio-backup-$(date "+%Y_%m_%d_%H_%M").tar.gz
