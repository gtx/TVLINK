#
# This is unofficial dockerized precompiled TVLINK
#

# For new library glibc >=2.32 use Ubuntu Groovy or newer
# FROM ubuntu:groovy
FROM debian:stable-slim
MAINTAINER GT <gt.root@gmail.com>

# On linux systems you need to set this environment variable before run:
ENV GODEBUG="madvdontneed=1"

##ENV TVLINK_URL=https://api.github.com/repos/AlexELEC/TVLINK-x86_64/releases
ENV TVLINK_RELEASE="latest"
ENV TVLINK_PORT="2020"
ENV TVLINK_UPDATE="true"
ENV LINUX_NAME="linux"
ENV LINUX_UPDATE="true"


ENV URL_MAIN="https://github.com/AlexELEC/TVLINK-x86_64/releases/download"
ENV URL_LAST="https://github.com/AlexELEC/TVLINK-x86_64/releases/latest"
ENV TVLINK_DIR="/opt/tvlink"
ENV TVLINK_URL=

ENV UPD_VER=`curl -s "$URL_LAST" | sed 's|.*tag\/||; s|">redirected.*||')`


##COPY start_TS.sh /start_TS.sh
##COPY update_TS.sh /update_TS.sh

## RUN export DEBIAN_FRONTEND=noninteractive \
##   && chmod a+x /start_TS.sh && chmod a+x /update_TS.sh \
## && apt-get update && apt-get upgrade -y \
##   && apt-get install --no-install-recommends -y ca-certificates tzdata wget curl procps cron \
##  && apt-get clean \
##   && mkdir -p /opt/tvlink && chmod -R 666 /opt/tvlink \
##   && wget --no-verbose --output-document=/TS/TorrServer --tries=3 $(curl -s $TS_URL/$TS_RELEASE | \
##  grep browser_download_url | \
##   egrep -o 'http.+\w+' | \
##   grep -i "$(dpkg --print-architecture)" | \
##  grep -m 1 -i $LINUX_NAME) \
##  && chmod a+x /TS/TorrServer \
##  && touch /var/log/cron.log \
##  && ln -sf /proc/1/fd/1 /var/log/cron.log


RUN export DEBIAN_FRONTEND=noninteractive \
&& apt-get update && apt-get upgrade -y \
&& apt-get install --no-install-recommends -y ca-certificates tzdata wget curl procps cron \
&& apt-get clean \
&& mkdir -p /opt/tvlink && chmod -R 666 /opt/tvlink \
&& wget --no-verbose --output-document=/TS/TorrServer --tries=3 $(curl -s $TS_URL/$TS_RELEASE | \
   grep browser_download_url | \
   egrep -o 'http.+\w+' | \
   grep -i "$(dpkg --print-architecture)" | \
   grep -m 1 -i $LINUX_NAME) \
&& chmod a+x /TS/TorrServer \
&& touch /var/log/cron.log \
&& ln -sf /proc/1/fd/1 /var/log/cron.log
















##HEALTHCHECK --interval=5s --timeout=10s --retries=3 CMD curl -sS 127.0.0.1:2020 || exit 1

VOLUME [ "/opt/tvlink" ]

EXPOSE "$TS_PORT"

ENTRYPOINT [""]
