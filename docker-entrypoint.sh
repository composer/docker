#!/usr/bin/env bash

isCommand() {
    return composer help $1 > dev/null
}

# check if the first argument passed in looks like a flag
if [ "$(printf %c "$1")" = '-' ]; then
  set -- /sbin/tini -- composer "$@"
# check if the first argument passed in is composer
elif [ "$1" = 'composer' ]; then
  set -- /sbin/tini -- "$@"
# check if the first argument passed in matches a known command
elif isCommand "$1"; then
  set -- /sbin/tini -- composer "$@"
fi

exec "$@"
