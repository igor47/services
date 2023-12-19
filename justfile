set positional-arguments
STORAGE := justfile_directory() / "storage"

# list the available recipes
list:
  just --list --justfile {{justfile()}}

# encrypt the secrets.yaml file into secrets.encrypted
encrypt:
  docker compose run --rm dcsm.igor encrypt

# decrypt the secrets.encrypted file into secrets.yaml
decrypt:
  docker compose run --rm dcsm.igor decrypt

# run DCSM, processing all templates using encrypted secrets
dcsm:
  docker compose run --rm dcsm.igor

# reload docker services
reload:
  docker compose up --wait --detach --remove-orphans

# restart the specified service
restart service:
  docker compose restart {{service}}

# log output from all (or specified) service
logs service="":
  docker compose logs --follow --tail 100 {{service}}

# initialize postgres databases
postgres-init: dcsm
  docker compose exec -it postgres.igor /init_scripts/postgres_admin.sh
  docker compose exec -it postgres.igor /init_scripts/miniflux_db.sh

# make the directory structure for the storage volumes
mkdirs:
  #!/usr/bin/env bash
  set -euo pipefail
  #
  echo storage is {{STORAGE}}
  #
  # make sure the storage symlink is valid
  if [ -L {{STORAGE}} ];
  then
    if [ ! -e {{STORAGE}} ];
    then
      echo "storage symlink is invalid; please re-create it"
      exit 1
    fi
  else
    echo "storage symlink is missing; please create it"
    exit 1
  fi
  #
  # for traefik acme certs
  mkdir -p {{STORAGE}}/services/traefik/acme
  # for caddy
  mkdir -p {{STORAGE}}/services/caddy/data
  mkdir -p {{STORAGE}}/services/caddy/config
  # make directories for host-mounted service data
  mkdir -p {{STORAGE}}/services/postgres/data
  # for photoprism
  mkdir -p {{STORAGE}}/services/photoprism/storage
  # mariadb
  mkdir -p {{STORAGE}}/services/mariadb/mysql

# install the systemd service
install: mkdirs
  sed -e 's%WorkingDirectory=.*$%WorkingDirectory={{justfile_directory()}}%' {{justfile_directory()}}/compose.service > ~/.config/systemd/user/compose.service
  systemctl --user daemon-reload
  systemctl --user enable compose
  systemctl --user status compose
