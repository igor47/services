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

## usage

control the service with `systemctl`:

```bash
$ systemctl --user <status|start|stop> igor47.dc
```

to view logs, use `journalctl`:

```bash
$ journalctl --user -f -u igor47.dc
```

## minifux

configuration comes from [here](https://miniflux.app/docs/installation.html#docker).
to configure miniflux, you have to create the postgres user for it:

```bash
$ docker-compose exec postgres /init_scripts/miniflux_db.sh
```

don't forget to change the default password, specified in the docker compose file.
