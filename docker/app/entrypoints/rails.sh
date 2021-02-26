#!/bin/sh

set -x

rm -rf /app/tmp/pids/server.pid
rm -rf /app/tmp/cache/*

echo "Waiting for postgres to become ready...."

$(docker/app/entrypoints/helpers/pg_database_url.sh)
PG_READY="pg_isready -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USERNAME"

until $PG_READY
do
  sleep 2;
done

echo "Database ready to accept connections."

bundle install

BUNDLE="bundle check"

until $BUNDLE
do
  sleep 2;
done

exec "$@"
