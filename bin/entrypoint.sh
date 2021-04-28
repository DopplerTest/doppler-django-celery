#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset
set -e

./bin/wait-for-it.sh ${REDIS_HOSTNAME}:${REDIS_PORT} -- echo "[info]: Redis is up at ${REDIS_HOSTNAME} on ${REDIS_PORT}."

echo '[info]: Collecting static resources'
./manage.py collectstatic --noinput

echo '[info]: Performing database migrations'
./manage.py migrate --noinput

echo "[info]: Starting application with command - \"${@}.\""
exec "$@"
