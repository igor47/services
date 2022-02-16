# services

web servers for igor.moomers.org

## installation

this repo is meant to be cloned into `~/repos/igor.services` -- this path is hardcoded into the `install.sh` and `igor47.dc.service` files.
after cloning, run `install.sh` to set up the systemd service, called `igor47.dc`.

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

to configure miniflux, you have to create the user for it:

```bash
$ docker-compose exec postgres /init_scripts/miniflux_db.sh
```

you will also need to create an admin user, as detailed [here](https://miniflux.app/docs/installation.html#docker):

```bash
$ docker-compose exec miniflux /usr/bin/miniflux -create-admin
```
