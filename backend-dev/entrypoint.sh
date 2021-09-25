#!/bin/sh


ROOT=/root/.hydro
mkdir -p $ROOT

cd "$ROOT/../Hydro-dev"

if [ ! -f "$ROOT/addon.json" ]; then
    echo '["@hydrooj/ui-default"]' > "$ROOT/addon.json"
fi

if [ ! -f "$ROOT/config.json" ]; then
    # TODO 变成变量
    echo '{"host": "oj-mongo", "port": "27017", "name": "hydro", "username": "", "password": ""}' > "$ROOT/config.json"
fi

if [ ! -f "$ROOT/first" ]; then
    echo "for marking use only!" > "$ROOT/first"
    npx hydrooj cli system set file.accessKey "$ACCESS_KEY"
    npx hydrooj cli system set file.secretKey "$SECRET_KEY"
    # TODO 变成变量
    npx hydrooj cli system set file.endPoint http://oj-minio:9000/
	
    npx hydrooj cli user create systemjudge@systemjudge.local judger judgerjudger 2
    npx hydrooj cli user setJudge 2

fi
rm -f /tmp/hydro/lock.json
mkdir -p /tmp/hydro/public   
echo Running in Dev mode.

trap "echo 'received stop signal'; exit 0" TERM

pm2 start /root/watch-compile.sh --interpreter bash
pm2 start packages/hydrooj/bin/hydrooj.js -i 8 --name hydrooj --restart-delay=2000 --node-args="--async-stack-traces --trace-deprecation" -- --debug --template --benchmark
pm2 logs &

wait
