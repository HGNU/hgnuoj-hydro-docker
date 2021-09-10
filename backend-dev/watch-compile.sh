#!/bin/bash

healthcheck_path=/root/healthcheck.sh

#/bin/bash $healthcheck_path
#while [ $? -ne 0 ]
#do
#	sleep 5
#	/bin/bash $healthcheck_path
#done

echo starting compiling files...
#sleep 10
#yarn build:watch & # 编译后端
yarn build:ui:dev # 编译前端


