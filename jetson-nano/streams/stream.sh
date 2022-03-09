#!/bin/sh

FFMPEG='./../jetson-ffmpeg/build/ffmpeg/ffmpeg' # not neccessary anymore, but keeping this if needed to run older version
FFMPEG='ffmpeg'
PRESET='veryfast'
BITRATE='3M' # for h264_nvmpi you need to put here half of the disired bitrate, seems to be some strange bug or something

STREAM_URL='rtmp://a.rtmp.youtube.com/live2' # youtube stream server
STREAM_KEY='put-your-stream-key-here' # youtube stream key
STREAM_URL='rtmp://fra02.contribute.live-video.net/app' # twitch stream server
STREAM_KEY='live_0123456789abcdefxyz' # twitch stream key

# v4l2-ctl -c brightness=-14 && v4l2-ctl -c contrast=143 && v4l2-ctl -c saturation=130 && v4l2-ctl -c hue=0 > /dev/null # "Webcam" Settings for USB 3.0 Video

##$FFMPEG -i rtmp://192.168.2.25:1935/live/test -c:a:0 copy -c:v h264_nvmpi -b:v $BITRATE -minrate $BITRATE -maxrate $BITRATE -bufsize 1M -f flv $STREAM_URL/$STREAM_KEY
#$FFMPEG -c:v h264_nvmpi -i rtmp://192.168.2.25:1935/live/test -c:a:0 copy -c:v h264_nvmpi -vf scale=1920:1080 -b:v $BITRATE -minrate $BITRATE -maxrate $BITRATE -bufsize 1M -f flv $STREAM_URL/$STREAM_KEY
##$FFMPEG -c:v h264_nvmpi -i rtmp://192.168.2.25:1935/live/test -f null -

# USB 3.0 Video Capture
$FFMPEG -ar 48000 -ac 2 -f alsa -i hw:2,0 -f v4l2 -pix_fmt yuyv422 -framerate 30 -video_size 1920x1080 -itsoffset 0.25 -i /dev/video0 -copyinkf -c:a aac -b:a 320k -c:v h264_nvmpi -x264-params keyint=120 -b:v $BITRATE -minrate $BITRATE -maxrate $BITRATE -bufsize $BITRATE -f flv $STREAM_URL/$STREAM_KEY
# hw:2,0 - 'arecord -l' gives you that card 2 device 0 is the audio input, written as 2,0
# -itsoffset 0.25 - about the delay which the audio copy plugin i'm using with obs to copy audio from output device to camlink adds (0.25 seconds)
# If the stream erros, try 'arecord -l', which kind of activates some audio sources, not sure what it does exactly but might fix something

# PiCam 2
#$FFMPEG -f video4linux2 -video_size 1920x1080 -framerate 30 -i /dev/video0 -c:v h264_nvmpi -b:v $BITRATE -minrate $BITRATE -maxrate $BITRATE -bufsize $BITRATE -f flv $STREAM_URL/$STREAM_KEY
