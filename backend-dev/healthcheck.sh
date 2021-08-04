#!/bin/sh

host=127.0.0.1
port=8888

nc -w 1 -z $host $port 2>&1 >/dev/null
if [ $? -eq 0 ];then
	exit 0
else
	exit 1
fi
