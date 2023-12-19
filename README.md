# services

run services via docker-compose and traefik.

## installation

clone the repo:

```bash
$ git clone git@github.com:igor47/services.git igor.services
```

after cloning, run `just install` to set up the systemd service, called `compose`.

## usage

control the service with `systemctl`:

```bash
$ systemctl --user <status|start|stop> compose
```

other commands are available via `just`.
for instance, to view logs, use `just logs`:

## postgres

init is available via init scripts.
run `just postgres-init` to create all dbs and users.
if you want a shell in postgres:

```bash
$ docker compose exec -it igor.postgres /bin/bash
```

### TODO: backups

we should back up the postgres db somehow...

## minifux

configuration comes from [here](https://miniflux.app/docs/installation.html#docker).
don't forget to change the default password.
