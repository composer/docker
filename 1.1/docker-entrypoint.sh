#!/bin/bash

DOCKER_UID=${DOCKER_UID:-1}
DOCKER_USER=${DOCKER_USER:-root}

set -- composer "$@"

# run under uid/user specified if not equal to defaults
if [ "root" != "$DOCKER_USER" ] && [ "1" != "$DOCKER_UID" ];
then
    adduser -H -D -u $DOCKER_UID $DOCKER_USER
    chown -R $DOCKER_USER "$COMPOSER_HOME"

    set -- su-exec $DOCKER_USER "$@"
fi

exec /sbin/tini -- "$@"
