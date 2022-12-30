#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

# directory for caddy state
mkdir -p ~igor47/services/caddy/logs
mkdir -p ~igor47/services/caddy/storage

# for traefik acme certs
mkdir -p ~igor47/services/traefik/acme

# make directories for host-mounted service data
mkdir -p ~igor47/services/postgres/data

# install the systemd unit file
cp ~igor47/repos/igor.services/igor47.dc.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable igor47.dc

systemctl --user status igor47.dc
