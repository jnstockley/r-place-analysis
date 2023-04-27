#!/bin/bash
mkdir data/

curl https://placedata.reddit.com/data/canvas-history/2022_place_canvas_history.csv.gzip -o data/data.csv.gz

gzip -d data/data.csv.gz

local_md5sum="446315c53d6d4d422f89ef0e73b41375"

echo "Checking checksum of downloaded file..."

downloaded_md5sum=$(md5sum data/data.csv | awk '{ print $1 }')

if [ "$local_md5sum" = "$downloaded_md5sum" ]; then
  echo "The checksums are correct"
else
  echo "Checksums don't match expected ${local_md5sum}, got ${downloaded_md5sum}"
fi