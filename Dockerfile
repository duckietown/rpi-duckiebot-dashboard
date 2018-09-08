# Base image
FROM afdaniele/compose-arm32v7:latest

# install ENTRYPOINT script
ADD assets/entrypoint_duckiebot.sh /root/entrypoint_duckiebot.sh

# configure ENTRYPOINT
ENTRYPOINT ["/root/entrypoint_duckiebot.sh"]
