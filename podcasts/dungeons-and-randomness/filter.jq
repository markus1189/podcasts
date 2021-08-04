"https://raw.githubusercontent.com/markus1189/podcasts/main/podcasts/dungeons-and-randomness/result/image.jpg" as $image |
1493617025 as $tstart |
(.rss.channel.item |
  map(
    select(
      (.pubDate | strptime("%a, %d %b %Y %X %z") | mktime >= $tstart) and
      (.title | contains("Extended Rest") | not)
    )
  )
) as $items |
.rss.channel.item = $items |
.rss.channel.title |= "\(.) - Starting from \($tstart | todate)" |
.rss.channel.image = $image |
(.rss.channel | .["itunes:image"]) = $image |
(.rss.channel | .["googleplay:image"]) = $image