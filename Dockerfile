# parameters
ARG DASHBOARD_NAME="duckiebot"

# ==================================================>
# ==> Do not change this code
ARG ARCH=arm32v7
ARG MAJOR=latest
ARG BASE_IMAGE=compose
ARG BASE_TAG=${MAJOR}-${ARCH}

# define base image
FROM afdaniele/${BASE_IMAGE}:${BASE_TAG}

# copy dependencies files only
COPY ./dependencies-apt.txt /tmp/

# install apt dependencies
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    $(awk -F: '/^[^#]/ { print $1 }' /tmp/dependencies-apt.txt | uniq) \
  && rm -rf /var/lib/apt/lists/*

# copy dependencies files only
COPY ./dependencies-py3.txt /tmp/

# install python dependencies
RUN pip3 install -r /tmp/dependencies-py3.txt

# copy dependencies files only
COPY ./dependencies-compose.txt /tmp/

# install compose dependencies
RUN python3 ${COMPOSE_DIR}/public_html/system/lib/python/compose/package_manager.py \
  --install $(awk -F: '/^[^#]/ { print $1 }' /tmp/dependencies-compose.txt | uniq)

# copy launch script
COPY ./launch.sh /launch.sh

# define launch script
ENV LAUNCHFILE "/launch.sh"

# redefine entrypoint
ENTRYPOINT "${LAUNCHFILE}"
# <== Do not change this code
# <==================================================

# configure \compose\
RUN python3 $COMPOSE_DIR/configure.py \
  --guest_default_page "mission-control" \
  --website_name "Duckiebot Dashboard" \
  --login_enabled 1 \
  --cache_enabled 1

# maintainer
LABEL maintainer="Andrea F. Daniele (afdaniele@ttic.edu)"
