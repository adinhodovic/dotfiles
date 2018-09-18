#!/usr/bin/env bash
set -e

server='ubuntu@34.254.239.115'

function sync {
  rsync -avz ~/work/ambrosus/ambrosus-ops/ansible "$server:~/" \
    --exclude=ambrosus-ops/.git/ \
    --exclude=ambrosus-ops/terraform
}

echo 'Removing server ~/ansible'
ssh "$server" "rm -rf ~/ansible"

echo Performing initial sync
sync

while inotifywait -e modify -r ambrosus-ops/ansible/*; do
  notify-send 'Syncing to amb-ops...' -i network-transmit-receive
  sync
  pkill xfce4-notifyd
done
