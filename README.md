# services

web services for igor.moomers.org

## installation

this repo is meant to be cloned into `~/repos/igor.services` -- this path is hardcoded into the `install.sh` and `igor47.dc.service` files.

```bash
$ git clone git@github.com:igor47/services.git ~/repos/igor.services
```

after cloning, run `install.sh` to set up the systemd service, called `igor47.dc`.

```bash
$ cd ~/repos/igor.services
$ ./install.sh
```

## proxy

this is meant to be run behind a [caddy proxy](https://caddyserver.com/).
this should be installed on debian systems [as instructed here](https://caddyserver.com/docs/install#debian-ubuntu-raspbian).

## usage

control the service with `systemctl`:

```bash
$ systemctl --user <status|start|stop> igor47.dc
```

to view logs, use `journalctl`:

```bash
$ journalctl --user -f -u igor47.dc
```

## postgres

the postgres port is available on an ephemeral port on localhost.
to connect to the postgres from the host, you have to figure out which port it's listening on.
run this command:

```bash
$ docker-compose port postgres 5432
```

### TODO: backups

we should back up the postgres db somehow...

## minifux

configuration comes from [here](https://miniflux.app/docs/installation.html#docker).
to configure miniflux, you have to create the postgres user for it:

```bash
$ docker-compose exec postgres /init_scripts/miniflux_db.sh
```

don't forget to change the default password, specified in the docker compose file.
