#!/bin/sh

for i in 1 2 3; do
  gpio write 2 1
  sleep 0.1
  gpio write 2 0
  sleep 0.2
done

# vim: set ts=2 sw=2 et:
