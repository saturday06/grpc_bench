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
export GRPC_CLIENT_CPUS=36
export GRPC_REQUEST_PAYLOAD=100B

rm -fr java_openj9_grpc_gencon_bench # なぜかビルドに失敗する
rm -fr java_aot_bench java_micronaut_bench java_micronaut_workstealing_bench # 正常なレスポンスを返さない
./build.sh
nohup sh -c 'for count in $(seq 5); do ./bench.sh; done' > bench.log 2>&1 &
tail -f bench.log
