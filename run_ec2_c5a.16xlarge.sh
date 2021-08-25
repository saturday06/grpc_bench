#!/bin/sh

set -eux
cd "$(dirname "$0")"

export GRPC_BENCHMARK_DURATION=120s
export GRPC_BENCHMARK_WARMUP=30s
export GRPC_SERVER_CPUS=16
export GRPC_SERVER_RAM=512m
export GRPC_CLIENT_CONNECTIONS=50
export GRPC_CLIENT_CONCURRENCY=1000
export GRPC_CLIENT_QPS=0
export RPC_CLIENT_CPUS=36
export GRPC_REQUEST_PAYLOAD=100B

rm -fr java_openj9_grpc_gencon_bench # なぜかビルドに失敗する
./build.sh
nohup ./bench.sh > bench.log 2>&1 &
tail -f bench.log
