#!/bin/bash -e

etcd_bin=${1}

test_dir=$(ps -ef | grep ${etcd_bin} | grep -- --data-dir | sed 's%.*data-dir[= ]\([^ ]*\).*%\1%')

docker inspect etcd | jq -r '.[].HostConfig.Binds[]' | grep "${test_dir}" | cut -d ":" -f 1 | xargs stat -c %a
