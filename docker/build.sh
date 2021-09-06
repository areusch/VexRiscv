#!/bin/bash -xe

cd "$(dirname "$0")"

docker build --no-cache --progress plain -t vex-riscv:latest .
