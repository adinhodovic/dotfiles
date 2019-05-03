#!/usr/bin/env bash
set -e

if [ "$1" = "" ] || [ "$2" = "" ] || [ "$3" = "" ];
then
  echo "Bad arguments passed:"
  echo "Arg1: the server,"
  echo "Arg2: the folder to sync,"
  echo "Arg3: The folder to delete,"
  echo "Arg4: The root folder to exclude files from"
  echo "Sample $ vps-sync hl-ops-deployment ~/company/honeylogic/ops ~/ops ops"
  exit
fi

server=$1
sync_folder=$2
exclude_folder=$4
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
  #pkill xfce4-notifyd
done
