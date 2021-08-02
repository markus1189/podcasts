#!/usr/bin/env bash

set -e

CONTENT="$(curl --fail -s 'https://www.spreaker.com/show/4064382/episodes/feed')"


wget --quiet -O image "$(echo "$CONTENT" | xq -r '.rss.channel.image.url')"
convert -negate image image

echo "$CONTENT" |
    xq -x '"https://github.com/markus1189/podcasts/blob/main/podcasts/dungeons-and-randomness/image?raw=true" as $image | 1493617025 as $tstart | (.rss.channel.item | map(select((.pubDate | strptime("%a, %d %b %Y %X %z") | mktime >= $tstart) and (.title | contains("Extended Rest") | not)))) as $items | .rss.channel.item = $items | .rss.channel.title |= "\(.) - Starting from \($tstart | todate)" | .rss.channel.image = $image | (.rss.channel | .["itunes:image"]) = $image | (.rss.channel | .["googleplay:image"]) = $image' > feed.xml
