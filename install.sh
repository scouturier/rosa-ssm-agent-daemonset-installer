#!/bin/sh

podman run -d --name ssm-agent \
  --device=/dev/ttyS0 \
  -v /var/run/dbus:/var/run/dbus \
  -v /run/systemd:/run/systemd \
  -v /etc/sudoers.d:/etc/sudoers.d \
  scouturier/ssm-agent:latest