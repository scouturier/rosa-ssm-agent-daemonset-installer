#!/bin/sh

docker run -d --restart unless-stopped --name ssm-agent \
  --device=/dev/ttyS0 \
  -v /var/run/dbus:/var/run/dbus \
  -v /run/systemd:/run/systemd \
  -v /etc/sudoers.d:/etc/sudoers.d \
  jmreicha/ssm-agent:latest