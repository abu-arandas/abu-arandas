#!/bin/sh
# Vertical 9:16 reel versions of the captioned clips: the clip centred over a blurred, darkened copy of itself.
set -e
F=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf
for c in intro till shop-checkout back-office arabic-dark; do
  ffmpeg -loglevel error -y -i clip-$c.mp4 -filter_complex \
  "[0:v]split[a][b];[a]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,boxblur=30:2,eq=brightness=-0.42:saturation=0.6[bg];[b]scale=1080:-2[fg];[bg][fg]overlay=(W-w)/2:(H-h)/2,drawtext=fontfile=$F:text='Arandas Tech':fontcolor=white:fontsize=84:x=(w-text_w)/2:y=300,drawtext=fontfile=$F:text='Shop · Till · Back office':fontcolor=0xFF9A7A:fontsize=40:x=(w-text_w)/2:y=410,drawtext=fontfile=$F:text='wa.me/962791568798':fontcolor=white:fontsize=40:x=(w-text_w)/2:y=h-380" \
  -c:v libx264 -preset slow -crf 27 -pix_fmt yuv420p -c:a copy -movflags +faststart reel-$c.mp4
done
