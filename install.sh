#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

# for traefik acme certs
mkdir -p ${HOME}/services/traefik/acme

# for caddy
mkdir -p ${HOME}/services/caddy/data
mkdir -p ${HOME}/services/caddy/config

# make directories for host-mounted service data
mkdir -p ${HOME}/services/postgres/data

# for photoprism
mkdir -p ${HOME}/services/photoprism/storage

# mariadb
mkdir -p ${HOME}/services/mariadb/mysql

# install the systemd unit file
cp ${HOME}/repos/compose.services/compose.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable compose

systemctl --user status compose
