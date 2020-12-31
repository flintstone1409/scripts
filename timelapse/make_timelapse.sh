#!/bin/sh

# This script convertes a series of images into a video timelapse.
# Only requirement is to have ffmpeg installed, taking ls and grep for granted.

# I personally use this to create a video out of pictures that are taken by
# MotionEye every 15 seconds. The resulting video has 60fps, the resolution of
# your images and is named after the folder containing the images (it goes
# through every subfolder of the folder you're executing the script from).
# It runs only on folders, that contain an image with the filename 'imagelast'
# and don't contain files that match the regex 'fileregex' (although this could
# be done easier by the inverted pattern used in the ffmpeg command).

# The final videos are collected in another subfolder called 'video'.

startdir=$(pwd)
imagelast='17-59-45.jpg'
fileregex='(0[0-5]|1[8-9]|2[0-3])(-[0-9]{2}){2}.jpg'
mkdir video # will be used to collect build artifacts

for module in */
do
  module=${module%%/} # removes / at the end of the foldername
  cd $startdir/$module
  if [ $(ls -1 | grep $imagelast | wc -l) -gt 0 ] # if folder contains the last required image
  then
    if [ $(ls -1 | grep -E $fileregex | wc -l) -lt 1 ] # folder must not contain unwanted images
    then
      ffmpeg -framerate 60 -pattern_type glob -i '*.jpg' -c:v libx264 -preset medium -crf 0 -pix_fmt yuv420p ${PWD##*/}.mp4
      mv *.mp4 $startdir/video/
    fi
  fi
done