#!/usr/bin/env bash
set -e

#server='10.0.144.79'
#proxy='52.210.164.117'
#function sync {
#  rsync 'ssh -o "ProxyCommand ssh -A $proxy -W %h:%p"' -avz ~/work/ambrosus/ambrosus-#ops/ansible "$server:~/" \
#    --exclude=ambrosus-ops/.git/ \
#    --exclude=ambrosus-ops/terraform
#}

server='ubuntu@52.210.95.251'

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
