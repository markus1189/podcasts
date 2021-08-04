#!/usr/bin/env bash

set -e

CONTENT="$(curl --fail -s 'https://www.spreaker.com/show/4064382/episodes/feed')"


wget --quiet -O image.jpg "$(echo "$CONTENT" | xq -r '.rss.channel.image.url')"
convert -negate image.jpg image.jpg

echo "$CONTENT" | xq -x -f filter.jq > feed.xml
