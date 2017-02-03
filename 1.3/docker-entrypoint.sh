#!/bin/bash

sed -ie "s/$TMP_UID/$DEV_UID/g" /etc/passwd
sed -ie "s/$TMP_UID/$DEV_GID/g" /etc/group

exec /sbin/tini -- gosu $DEV_UID:$DEV_GID composer "$@"
