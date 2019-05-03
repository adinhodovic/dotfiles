#!/usr/bin/env bash
set -e

server=$1
sync_folder=$2
exclude_folder=$4
echo "$exclude_folder"
function sync {
  rsync -avz "$sync_folder" "$server:~/" \
    --exclude="$exclude_folder/.git/" \
    --exclude="$exclude_folder/terraform/environments/dev/.terraform/" \
    --exclude="$exclude_folder/terraform/environments/ops/.terraform/" \
    --exclude="$exclude_folder/terraform/environments/prod/.terraform/" \
    --exclude="$exclude_folder/terraform/environments/test/.terraform/"
}

echo "Removing server $3"
ssh "$server" "rm -rf $3"

echo 'Performing initial sync'
sync

while inotifywait -e modify -r ~/work/ambrosus/ambrosus-ops/*; do
 notify-send 'Syncing to $1...' -i network-transmit-receive
  sync
  pkill xfce4-notifyd
done
