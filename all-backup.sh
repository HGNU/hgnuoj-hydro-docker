#!/bin/bash
echo backuping mongodb...
bash ./mongodb-backup.sh
echo backuping minio files...
bash ./minio-backup.sh
echo backup complete!