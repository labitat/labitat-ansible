#!/bin/bash

set -e

case "$RENEWED_LINEAGE" in
*/space.labitat.dk)
  install -m640 -o root -g radiusd \
    "$RENEWED_LINEAGE/privkey.pem" \
    "$RENEWED_LINEAGE/fullchain.pem" \
    /etc/raddb/certs/
  systemctl restart radiusd.service
  ;;
esac

# vim: set ts=2 sw=2 et:
