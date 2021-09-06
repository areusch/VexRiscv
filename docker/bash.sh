#!/usr/bin/env bash

# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

#
# Start a bash, mount /workspace to be current directory.
#
# Usage: bash.sh <CONTAINER_TYPE> [-i] [--net=host] [--mount path] <CONTAINER_NAME>  <COMMAND>
#
# Usage: docker/bash.sh <CONTAINER_NAME>
#     Starts an interactive session
#
# Usage2: docker/bash.sh [-i] <CONTAINER_NAME> [COMMAND]
#     Execute command in the docker image, default non-interactive
#     With -i, execute interactively.
#

set -e

interactive=1

CI_DOCKER_EXTRA_PARAMS=( )

# Mount external directory to the docker
CI_DOCKER_MOUNT_CMD=( )

DOCKER_IMAGE_NAME=vex-riscv:latest

if [ "$#" -eq 0 ]; then
    COMMAND="bash"
    interactive=1
else
    COMMAND=("$@")
fi

if [ $interactive -eq 1 ]; then
    CI_DOCKER_EXTRA_PARAMS=( "${CI_DOCKER_EXTRA_PARAMS[@]}" -it )
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE="$(pwd)"

DOCKER_ENVS=""
DOCKER_DEVICES=""
WORKSPACE_VOLUMES=""

# Print arguments.
echo "WORKSPACE: ${WORKSPACE}"
echo "DOCKER CONTAINER NAME: ${DOCKER_IMAGE_NAME}"
echo ""

echo "Running '${COMMAND[@]}' inside ${DOCKER_IMAGE_NAME}..."

# When running from a git worktree, also mount the original git dir.
EXTRA_MOUNTS=( )
if [ -f "${WORKSPACE}/.git" ]; then
    git_dir=$(cd ${WORKSPACE} && git rev-parse --git-common-dir)
    if [ "${git_dir}" != "${WORKSPACE}/.git" ]; then
        EXTRA_MOUNTS=( "${EXTRA_MOUNTS[@]}" -v "${git_dir}:${git_dir}" )
    fi
fi

# By default we cleanup - remove the container once it finish running (--rm)
# and share the PID namespace (--pid=host) so the process inside does not have
# pid 1 and SIGKILL is propagated to the process inside (jenkins can kill it).
docker run --rm --pid=host\
    ${DOCKER_DEVICES}\
    ${WORKSPACE_VOLUMES}\
    -v ${WORKSPACE}:${WORKSPACE} \
    -v ${SCRIPT_DIR}:/docker \
    "${CI_DOCKER_MOUNT_CMD[@]}" \
    "${EXTRA_MOUNTS[@]}" \
    -w ${WORKSPACE} \
    -e "CI_BUILD_HOME=${WORKSPACE}" \
    -e "CI_BUILD_USER=$(id -u -n)" \
    -e "CI_BUILD_UID=$(id -u)" \
    -e "CI_BUILD_GROUP=$(id -g -n)" \
    -e "CI_BUILD_GID=$(id -g)" \
    ${DOCKER_ENVS} \
    ${CI_ADDON_ENV} \
    ${CUDA_ENV} \
    "${CI_DOCKER_EXTRA_PARAMS[@]}" \
    ${DOCKER_IMAGE_NAME} \
    bash --login /docker/with_the_same_user \
    "${COMMAND[@]}"
