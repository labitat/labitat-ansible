#!/bin/sh

# Background:
#   RFC 8327 / BCP 214
#     Mitigating the Negative Impact of Maintenance through
#     BGP Session Culling
#     https://datatracker.ietf.org/doc/html/rfc8327

disable_bgp_local_peers() {
	# peers that are multi-homed, and wishes advance
	# notice before reboots, so BGP can do it's thing
	# and re-route traffic.

	# asbjorn
	birdc disable asbjorn_ipv4
	birdc disable asbjorn_ipv6
}

enable_bgp_culling() {
	# BGP culling through nftables is assumed
	# unnecessary at this time, as there properly
	# aren't any multi-hop sessions routed across
	# the space server, except maybe BGP.tools feeds.
	true # implement when needed
}

disable_bgp_local_peers
enable_bgp_culling

# wait for routes to be withdrawn and synced
sleep 5

# reboot system
exec systemctl reboot
