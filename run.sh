#!/bin/sh

set -eux
cd "$(dirname "$0")"

export GRPC_BENCHMARK_DURATION=120s
export GRPC_BENCHMARK_WARMUP=30s
export GRPC_SERVER_CPUS=3
export GRPC_SERVER_RAM=512m
export GRPC_CLIENT_CONNECTIONS=50
export GRPC_CLIENT_CONCURRENCY=1000
export GRPC_CLIENT_QPS=0
export GRPC_CLIENT_CPUS=9
export GRPC_REQUEST_PAYLOAD=100B

./build.sh
nohup ./bench.sh > bench.log 2>&1 &
tail -f bench.log
