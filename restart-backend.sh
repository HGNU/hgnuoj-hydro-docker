#!/bin/sh

container_name=oj-backend

echo 重启OJ后端
sudo docker exec -it $container_name pm2 restart hydrooj
