#!/usr/bin/env bash

# constants
HOSTNAME=$(hostname)

# configure \compose\
python3 $COMPOSE_DIR/configure.py \
  --navbar_title "${HOSTNAME}" \
  --logo_white "http://${HOSTNAME}.local/data/duckietown/images/logo.png" \
  --logo_black "http://${HOSTNAME}.local/data/duckietown/images/logo.png"

# run base entrypoint
/root/entrypoint.sh
