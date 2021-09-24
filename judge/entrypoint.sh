#!/bin/sh

ROOT=/root/.config/hydro
mkdir -p $ROOT
if [ ! -f "$ROOT/judge.yaml" ]; then
    cp /root/judge.yaml $ROOT
fi
ulimit -s unlimited
pm2 start sandbox
cd /root/hydro-dev
yarn
pm2-runtime start ./packages/hydrojudge/bin/hydrojudge.js
