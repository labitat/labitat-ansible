#!/bin/sh

for i in 1 2 3; do
  gpio write 2 1
  sleep 0.01
  gpio write 2 0
  sleep 0.1
  gpio write 2 1
  sleep 0.01
  gpio write 2 0
  sleep 0.01
  gpio write 2 1
  sleep 0.01
  gpio write 2 1
  sleep 0.01
  gpio write 2 0
  sleep 0.01
  gpio write 2 1
  sleep 0.01
  gpio write 2 0
  sleep 0.1
  gpio write 2 1
  sleep 0.01
  gpio write 2 0
  sleep 0.01
  gpio write 2 1
  sleep 0.01
  gpio write 2 1
  sleep 0.01
  gpio write 2 0
done
