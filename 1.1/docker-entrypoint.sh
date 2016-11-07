#!/bin/bash

DOCKER_UID=${DOCKER_UID:-1}
DOCKER_USER=${DOCKER_USER:-root}

isCommand() {
  for cmd in \
    "about" \
    "archive" \
    "browse" \
    "clear-cache" \
    "clearcache" \
    "config" \
    "create-project" \
    "depends" \
    "diagnose" \
    "dump-autoload" \
    "dumpautoload" \
    "exec" \
    "global" \
    "help" \
    "home" \
    "info" \
    "init" \
    "install" \
    "licenses" \
    "list" \
    "outdated" \
    "prohibits" \
    "remove" \
    "require" \
    "run-script" \
    "search" \
    "self-update" \
    "selfupdate" \
    "show" \
    "status" \
    "suggests" \
    "update" \
    "validate" \
    "why" \
    "why-not"
  do
    if [ -z "${cmd#"$1"}" ]; then
      return 0
    fi
  done

  return 1
}

# see if the first argument passed in looks like a flag
if [ "$(printf %c "$1")" == '-' ]; then
  set -- /sbin/tini -- composer "$@"
# see if the first argument passed in matches a known command
elif isCommand "$1"; then
  set -- /sbin/tini -- composer "$@"
fi

# run under uid/user specified if not equal to defaults
if [ "root" != "$DOCKER_USER" ] && [ "1" != "$DOCKER_UID" ]; then
  adduser -H -D -u "$DOCKER_UID" "$DOCKER_USER"
  set -- su-exec "$DOCKER_USER" "$@"
fi

exec "$@"
