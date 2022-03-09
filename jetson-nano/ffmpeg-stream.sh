#!/bin/sh

PRESET='veryfast'
BITRATE='6M'
# STREAM_URL='rtmp://a.rtmp.youtube.com/live2'
STREAM_URL='rtmp://fra02.contribute.live-video.net/app'
STREAM_KEY='<insert your key here>'

ffmpeg -i rtmp://localhost:1935/live/test -c:a:0 copy -c:v libx264 -preset $PRESET -x264-params "nal-hrd=cbr" -b:v $BITRATE -minrate $BITRATE -maxrate $BITRATE -bufsize 1M -f flv $STREAM_URL/$STREAM_KEY
