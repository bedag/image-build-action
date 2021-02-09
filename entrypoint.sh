#!/bin/sh -e
#
# Copyright © 2021 Bedag Informatik AG

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
run_command () {
  if [ "$DEBUG" = true ] ; then
    echo ${@}
  fi
  ${@}
}

# colors
NONE='\033[0m'
YLW='\033[1;33m'
BLUE='\033[1;34m'
RED='\033[1;31m'
GREEN='\033[1;32m'
PRPLE='\033[0;35m'

#defaults
MARKER="branch"
FILE="${INPUT_FILE:-image-build.yml}"
DINPUT=""${MARKER}-${GITHUB_REF##*/}" git_tag="${GITHUB_REF##*/}" git_ref="${GITHUB_REF}" git_repo="${GITHUB_REPOSITORY}" git_commit="${GITHUB_SHA}" ${INPUT_INPUT}"
ARGS="${INPUT_ARGS:-}"
PUSH="${INPUT_PUSH:-false}"
DEBUG="${INPUT_DEBUG:-false}"
DOCKER_REGISTRY="${INPUT_DOCKER_REGISTRY:-docker.io}"
DOCKER_USERNAME="${INPUT_DOCKER_USERNAME:-}"
DOCKER_PASSWORD="${INPUT_DOCKER_PASSWORD:-}"


# debug prints
if [ "$DEBUG" = true ] ; then
  printf "${BLUE}version: $(${IMAGE_BUILD_BIN} -v)${NONE}\n"
  # check action input
  printf "${BLUE}image-build file: ${FILE}${NONE}\n"
  printf "${BLUE}image-build INPUT: ${DINPUT}${NONE}\n"
  printf "${BLUE}image-build PUSH: ${PUSH}${NONE}\n"
  printf "${BLUE}image-build ARGS: ${ARGS}${NONE}\n"
  printf "${BLUE}image-build DEBUG: ${IMAGE_BUILD_DEBUG}${NONE}\n"
  printf "${BLUE}image-build DOCKER_REGISTRY: ${DOCKER_REGISTRY}${NONE}\n"
  printf "${BLUE}image-build DOCKER_USER: ${DOCKER_USERNAME}${NONE}\n"
fi

# IF push true set correct flag
if [ "$PUSH" = true ] ; then
  PUSH="--push"
else
  unset PUSH
fi

# docker login
if [ ! -z "$DOCKER_USERNAME" ] && [ ! -z "$DOCKER_PASSWORD" ]; then
  run_command docker login ${DOCKER_REGISTRY} -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
fi

# run image build
run_command ${IMAGE_BUILD_BIN} -f ${FILE} ${PUSH} -s ${DINPUT}
