#!/bin/sh

set -e

ip route add unreachable 185.38.175.0/24
ip route add unreachable 2a01:4260:1ab::/48
