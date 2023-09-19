#!/bin/bash
# This assumes a php-fpm container via exposed port 9000,
# with a bind mount of the current working directory
# and the container has phpunit installed.
HOST_MNT="/host_mnt$(pwd)"
CONTAINER_ID=$(docker ps -q -n=-1 -f expose=9000/tcp -f status=running -f volume="$HOST_MNT")

ARGS=$(echo "$@" | sed "s:$(pwd)/::g")

docker exec -t "$CONTAINER_ID" vendor/bin/phpunit -d memory_limit=2G "$ARGS"
