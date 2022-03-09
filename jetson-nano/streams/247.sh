#!/bin/sh

INPUT1=Videos/1.mp4
INPUT2=Videos/2.mp4
INPUT3=Videos/3.mp4
INPUT4=Videos/4.mp4

FFMPEG='ffmpeg' # ffmpeg command
PRESET='veryfast'
BITRATE='3M' # for h264_nvmpi you need to put half of the disired bitrate here, seems to be some strange bug or something, explanation below
# STREAM_URL='rtmp://a.rtmp.youtube.com/live2' # Use this line if you want to stream to YouTube
STREAM_URL='rtmp://fra02.contribute.live-video.net/app' # Maybe change this according to your location
STREAM_KEY='live_123456789abcdefxyz' # Your Stream Key

# "Webcam" Settings for cheap USB HDMI Grabber, changes color settings to make it look like it should
v4l2-ctl -c brightness=-14 && v4l2-ctl -c contrast=143 && v4l2-ctl -c saturation=130 && v4l2-ctl -c hue=0 > /dev/null

# Not sure what this was
#ffmpeg -i Videos/1.mp4 -i Videos/2.mp4 -i Videos/3.mp4 -i Videos/4.mp4 -filter_complex "[0:v][1:v][2:v][3:v]xstack=inputs=4:layout=0_0|w0_0|0_h0|w0_h0[v]" -map "[v]" -c:a:0 copy -c:v h264_nvmpi -r 30 -b:v $BITRATE -minrate $BITRATE -maxrate $BITRATE -bufsize 1M -f flv $STREAM_URL/$STREAM_KEY

# also not sure
#ffmpeg -i Videos/1.mp4 -i Videos/2.mp4 -i Videos/3.mp4 -i Videos/4.mp4 -filter_complex "[0:v][1:v][2:v][3:v]xstack=inputs=4:layout=0_0|w0_0|0_h0|w0_h0[v]" -map "[v]" -c:v h264_nvmpi -vf scale=1920:1080 -crf 20 -pix_fmt yuv420p out.mp4

# "Latest version" of the command, which should work best of them
ffmpeg -i $INPUT1 -i $INPUT2 -i $INPUT3 -i $INPUT4 -filter_complex "[0:v][1:v]hstack=inputs=2[top];[2:v][3:v]hstack=inputs=2[bottom];[top][bottom]vstack=inputs=2[v]" -map "[v]" -c:v libx264 -preset ultrafast -crf 20 -pix_fmt yuv420p out.mp4
