# Base image
FROM afdaniele/compose:latest-arm32v7

# enable ARM
RUN [ "cross-build-start" ]

# install packages
RUN python3 $COMPOSE_DIR/public_html/system/lib/python/compose/package_manager.py \
  --install duckietown_duckiebot

# configure \compose\
RUN python3 $COMPOSE_DIR/configure.py \
  --guest_default_page "mission-control" \
  --website_name "Duckiebot Dashboard" \
  --login_enabled 1 \
  --cache_enabled 1

# disable ARM
RUN [ "cross-build-end" ]

# install ENTRYPOINT script
ADD assets/entrypoint_duckiebot.sh /root/entrypoint_duckiebot.sh

# configure ENTRYPOINT
ENTRYPOINT ["/root/entrypoint_duckiebot.sh"]
