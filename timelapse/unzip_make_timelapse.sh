#!/bin/sh

# Short Info: Unzips an archive and then generates a video out of the images
#   contained in the folders.

# Usage: The folder where you start this script should contain a bunch of .zip
#   archives but nothing else. Just execute this scipt. Of course, the archives
#   should only contain images (if something else than .jpg, change it below).

# Requirements:
#   - ffmpeg

startdir=$(pwd)
mkdir video # will be used to collect build artifacts

# Unzip all the archives
ls * | xargs -n 1 --max-procs $(nproc --all) unzip

for module in */
do
  module=${module%%/} # removes / at the end of the foldername
  cd $startdir/$module
  ffmpeg -framerate 60 -pattern_type glob -i '*.jpg' -c:v libx264 -preset medium -crf 0 -pix_fmt yuv420p ${PWD##*/}.mp4
  mv *.mp4 $startdir/video/
done
