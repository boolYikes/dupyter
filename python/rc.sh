#!/bin/bash

NETWORK=$2
SCRIPT_PATH=$1
REQUIREMENTS_FILE=$3

if [ -z "$SCRIPT_PATH" ]; then
    echo "Usage: $0 <local-python-script-path> <docker-network> <requirements-path>"
    echo "You at least must provide python script path"
    exit 1
fi

# Use default if no network was provided
if [ -z "$NETWORK" ]; then
    NETWORK="bridge"
fi
# Use default name if no req was provided
if [ -z "$REQUIREMENTS_FILE" ]; then
    REQUIREMENTS_FILE="requirements.txt"
fi

SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
SCRIPT_FILE=$(basename "$SCRIPT_PATH")

# Make an empty req file as default
if [ -f "$SCRIPT_DIR/$REQUIREMENTS_FILE" ]; then
    touch "$SCRIPT_DIR/$REQUIREMENTS_FILE"
fi

docker run --rm -it \
    --network "$NETWORK" \
    -v "$SCRIPT_DIR":/app \
    -w /app \
    python:3.14-rc-slim \
    bash -c "pip install -r '$REQUIREMENTS_FILE' --quiet --root-user-action=ignore && python '$SCRIPT_FILE'"
