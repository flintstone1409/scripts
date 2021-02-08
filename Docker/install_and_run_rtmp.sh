#!/bin/sh

# run: nano install.sh && chmod +x install.sh && ./install.sh
# this will open nano, there you paste this script, save and quit
# and everything gets installed as needed. Made for Ubuntu 20.04 on AMD64,
# for other distros you need to edit the docker part (don't forget the arch!)

# For people who want to run the RTMP Server on ARM64, use this
# container: datarhei/nginx-rtmp:1.15.0-dev-aarch64 (this guy also has containers
# for ARM32 and AMD64)

# normal update and install tools (on most distributions pre installed)
sudo apt update
sudo apt full-upgrade -y
sudo apt install -y htop nano wget curl tmux

# Install docker with everything
sudo apt remove docker docker-engine docker.io containerd runc
sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo adduser $(whoami) docker

# run rtmp server
sudo systemctl enable docker
docker run --name rtmp -d --restart unless-stopped -p 1935:1935 -p 8080:8080 jasonrivers/nginx-rtmp

# disable password login
sudo echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config

# install obs with qt stuff (installs probably more than needed, but I'm too lazy to find out whats unneccessary)
sudo apt install -y ffmpeg

echo '#!/bin/sh' > ffmpeg_stream.sh
echo "" >> ffmpeg_stream.sh
echo "PRESET='veryfast'" >> ffmpeg_stream.sh
echo "BITRATE='6M'" >> ffmpeg_stream.sh
echo ""
echo "# Uncomment whatever streaming Server you need"
echo ""
echo "# YouTube"
echo "# STREAM_URL='rtmp://a.rtmp.youtube.com/live2'" >> ffmpeg_stream.sh
echo "STREAM_URL='rtmp://fra02.contribute.live-video.net/app'" >> ffmpeg_stream.sh
echo "STREAM_KEY='<insert your key here>'" >> ffmpeg_stream.sh
echo "" >> ffmpeg_stream.sh
echo 'ffmpeg -i rtmp://localhost:1935/live/test -c:a:0 copy -c:v libx264 -preset $PRESET -x264-params "nal-hrd=cbr" -b:v $BITRATE -minrate $BITRATE -maxrate $BITRATE -bufsize 1M -f flv $STREAM_URL/$STREAM_KEY' >> ffmpeg_stream.sh
echo "" >> ffmpeg_stream.sh

chmod +x ffmpeg_stream.sh
