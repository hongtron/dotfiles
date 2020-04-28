#!/bin/bash

set -o pipefail

# install docker
if [[ -z "$(which docker)" ]]; then
  curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh
fi

# install docker-compose
if [[ -z "$(which docker-compose)" ]]; then
  curl -L https://github.com/docker/compose/releases/download/1.25.5/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
fi


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cp $DIR/bin/devenv /usr/local/bin
cp $DIR/docker-compose.yml /usr/local/etc/devenv/docker-compose.yml
