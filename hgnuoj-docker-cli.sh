#!/bin/bash

container_name=oj-backend
compose_file=docker-compose-dev.yml

current_path=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

function restart-backend(){
	container_name=oj-backend
	echo 重启OJ后端...
	sudo docker exec -it $container_name pm2 restart hydrooj
	echo 重启完毕.
}
function restart-backend-docker(){
	echo 重启OJ后端Docker容器...
	sudo docker restart $container_name
}
function restart-docker(){
	echo 重启docker-compose...
	sudo docker-compose -f $compose_file --compatibility restart
}
function build(){
	echo 编译前端...
	sudo docker exec -it $container_name yarn build:ui
	echo 编译后端...
	sudo docker exec -it $container_name yarn build
}
function hydro-cli(){
	args=$@
	echo 执行Hydro-cli命令: "$args"
	sudo docker exec -it $container_name sh -c "cd /root/Hydro-dev; npx hydrooj cli $args"
}
function logs-backend(){
	echo 显示后端日志："$@"
	sudo docker exec -it $container_name pm2 logs $@
}
function logs-judge(){
	echo 显示评测机日志：
	sudo docker-compose -f $compose_file --compatibility logs $@ oj-judge
}
function logs-nginx(){
	echo 显示Nginx反代日志：
        sudo docker-compose -f $compose_file --compatibility logs $@ oj-nginx
}
function backend-yarn(){
        echo yarn命令："$@"
	sudo docker exec -it $container_name sh -c "cd /root/Hydro-dev; yarn `$@`"
}
function compose-up-build(){
	echo 构建镜像并运行：
	sudo docker-compose -f $compose_file --compatibility up -d --build
}
function compose-build(){
        echo 构建镜像：
        sudo docker-compose -f $compose_file --compatibility build
}
function compose-up(){
        echo 运行HGNUOJ：
        sudo docker-compose -f $compose_file --compatibility up -d
}
function backup-mongodb(){
	function onInterrupted(){
		echo "备份中断."
		sudo rm -rf /tmp/mongodb-backup-$1 
		sudo docker exec oj-mongo rm -rf /mongo-bak
		sudo rm -f ./backups/hgnuoj-mongodb-backup-$1.tar.gz
		exit 1
	}
	bak_date=$(date "+%Y_%m_%d_%H_%M")
	echo 备份Mongodb数据库中...
	echo 备份时间：$bak_date
	trap "onInterrupted $bak_date" INT
	mkdir -p ./backups
	sudo docker exec oj-mongo mongodump -o /mongo-bak
	sudo docker cp oj-mongo:/mongo-bak /tmp/mongodb-backup-$bak_date
	sudo docker exec oj-mongo rm -rf /mongo-bak
	sudo tar -zcf ./backups/hgnuoj-mongodb-backup-$bak_date.tar.gz /tmp/mongodb-backup-$bak_date
	sudo rm -rf /tmp/mongodb-backup-$bak_date
	echo 备份完毕！完成时间：$(date "+%Y_%m_%d_%H_%M")
}
function backup-minio(){
	function onInterrupted(){
                echo "备份中断."
                sudo rm -f ./backups/hgnuoj-minio-backup-$1.tar.gz
		exit 1
        }
	bak_date=$(date "+%Y_%m_%d_%H_%M")
	trap "onInterrupted $bak_date" INT
	echo 备份Minio文件中...
	echo 备份时间：$bak_date
	sudo sh -c "tar cf - ./data/minio | pigz -9 -p 64 > ./backups/hgnuoj-minio-backup-$bak_date.tar.gz"
	echo 备份完毕！完成时间：$(date "+%Y_%m_%d_%H_%M")
}
function backup-all(){
	backup-mongodb
	backup-minio
}
function backup-prune(){
	echo 清理过期备份...
} 
args=''
index=0
for arg in "$@"
do
	if [ $index -eq 0 ];then
		let index++
		continue
	fi
	args="$args$arg "
	let index++
	
done
case "$1" in
	restart-backend)
		restart-backend
	;;
	build)
		build
	;;
	hydro-cli)
		hydro-cli $args
	;;
	logs-backend)
		logs-backend $args
	;;
	logs-judge)
		logs-judge $args
	;;
	logs-nginx)
                logs-nginx $args
        ;;
	backend-yarn)
                backend-yarn $args
        ;;
	restart-docker)
		restart-docker
	;;
	compose-up-build)
                compose-up-build
        ;;
	compose-build)
                compose-build
        ;;
	compose-up)
                compose-up
        ;;
	backup-mongodb)
		backup-mongodb
	;;
	backup-minio)
                backup-minio
        ;;
	backup-all)
                backup-all
        ;;
	backup-prune)
                backup-prune
        ;;
	*)
		echo 子命令无效！
	;;
esac

