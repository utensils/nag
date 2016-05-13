#!/bin/ash
set -e

# This is our container start-up script. 

# Warn if the DOCKER_HOST socket does not exist, borrowed from jwilder/nginx-proxy
if [[ $DOCKER_HOST == unix://* ]]; then
	socket_file=${DOCKER_HOST#unix://}
	if ! [ -S $socket_file ]; then
		cat >&2 <<-EOT
			ERROR: you need to share your Docker host socket with a volume at $socket_file
			Typically you should run your wombat/nag with: \`-v /var/run/docker.sock:$socket_file:ro\`
		EOT
	fi
fi

alias docker="docker -H $DOCKER_HOST"

MIX_ENV=prod mix run --no-halt
