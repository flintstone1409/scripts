# Jetson Nano - ffmpeg scripts

## Introduction

The NVIDIA Jetson Nano is a cheap computer and comparable to a Raspberry Pi.
The main difference is a builtin GPU, which is mostly used for faster AI operations, but also has a NVENC video encoder.
This video encoder is not supported by ffmpeg by default, but requires a patch.
This patch is applied when building ffmpeg using the build-ffmpeg script in this repository.
After building, the encoder can be used by using 'h264_nvmpi' as the codec.

Please note that this ffmpeg patch is not officially supported by NVIDIA (as far as I know) and might cause some problems from time to time, although it works pretty good in general.
There is a fork by [Keylost](https://github.com/Keylost/jetson-ffmpeg), that also supports newer versions of ffmpeg.

## Scripts in this folder

FFMPEG build scripts - these scripts are run from the user's directory, I'm not sure if they work from subdirectories (would have to check).

- [build.sh](build.sh): Older build script, not sure if it still works (had some trouble a while ago)
- [build-ffmpeg.sh](build-ffmpeg.sh): the current build script which I use

Scripts which start streams

- [ffmpeg-stream.sh](ffmpeg-stream.sh): pretty basic rtmp capture, reencode and push to twitch
- [streams/247.sh](streams/247.sh): A script that I set up for a 24/7 live stream, which for now just streams four videos over and over (not sure if it works at all)
- [streams/multistream.sh](streams/multistream.sh): Multiple sources (2x2 alignment), streaming to youtube or twitch if you want. Only thing not working right now is scaling the output (output will be what the 2x2 input leads to).
- [streams/stream.sh](streams/stream.sh): My main streaming script, allows RTMP and other direct input sources (like camlink or other video capture devices) as input and can stream to Twitch and YouTube (and every other platform that ffmpeg can stream to).
- [streams/youtube-stream.sh](streams/youtube-stream.sh): Restreams YouTube Videos or Streams, encodes using h264_nvmpi
- [streams/youtube-x264.sh](streams/youtube-x264.sh): Same as youtube-stream.sh but using x264 as encoder. The jetson nano is not powerful enough to make this work nicely.

My general recommendation would be to use the [streams/stream.sh](streams/stream.sh) script and uncomment whatever fits your needs.
This script is my main streaming script, while the other ones are mostly one-off tests.
