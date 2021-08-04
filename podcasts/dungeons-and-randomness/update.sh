#!/usr/bin/env bash

set -e

mkdir -p result

CONTENT="$(curl --fail -s 'https://www.spreaker.com/show/4064382/episodes/feed')"

wget --quiet -O result/image.jpg "$(echo "$CONTENT" | xq -r '.rss.channel.image.url')"
convert -negate result/image.jpg result/image.jpg

echo "$CONTENT" | xq -x -f filter.jq > result/feed.xml
