#!/bin/sh

container_name=oj-backend

echo 编译前端...
sudo docker exec -it $container_name yarn build:ui
echo 编译后端...
sudo docker exec -it $container_name yarn build
