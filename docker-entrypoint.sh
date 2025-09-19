#!/bin/sh
set -e

# If REDIS_PASSWORD is set, add --requirepass to the redis-server command
if [ -n "$REDIS_PASSWORD" ]; then
    # If the command is redis-server, add the requirepass option
    if [ "$1" = "redis-server" ]; then
        exec "$@" --requirepass "$REDIS_PASSWORD"
    else
        # For other commands, just execute them
        exec "$@"
    fi
else
    # No password set, execute the command as-is
    exec "$@"
fi