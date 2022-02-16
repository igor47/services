#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username postgres --dbname postgres <<-EOSQL
    CREATE USER miniflux WITH PASSWORD 'R72Zttsgd';
    CREATE DATABASE miniflux;
    GRANT ALL PRIVILEGES ON DATABASE miniflux TO miniflux;
EOSQL
