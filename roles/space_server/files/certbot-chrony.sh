#!/bin/bash

set -e

case "$RENEWED_LINEAGE" in
*/space.labitat.dk)
  install -m640 -o root -g chrony "$RENEWED_LINEAGE/fullchain.pem" /etc/chrony.cert
  install -m640 -o root -g chrony "$RENEWED_LINEAGE/privkey.pem" /etc/chrony.key
  systemctl restart chronyd.service
  ;;
esac

# vim: set ts=2 sw=2 et:
