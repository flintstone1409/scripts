# remove old installation
rm -Rf jetson-ffmpeg-old
mv jetson-ffmpeg/ jetson-ffmpeg-old

# making sure dependencies are installed and up to date
sudo apt update
sudo apt upgrade -y
sudo apt install gcc git make build-essential openssl libssl-dev gnutls-dev libx264-dev libx265-dev -y

# get jetson-ffmpeg
git clone https://github.com/jocover/jetson-ffmpeg.git
cd jetson-ffmpeg
#git checkout 7baa3d8 # not neccessary because the maintainer reverted this commit
mkdir build
cd build
cmake ..
make
sudo make install
sudo ldconfig

# clone and build ffmpeg
git clone git://source.ffmpeg.org/ffmpeg.git -b release/4.2 --depth=1
cd ffmpeg
cp ../../ffmpeg_nvmpi.patch .
git apply ffmpeg_nvmpi.patch
# might use --enable-gnutls, which is not compatible to --enable-openssl (so just use one of them)
./configure --enable-nvmpi --enable-openssl --enable-libx264 --enable-libx265 --enable-gpl --enable-nonfree
make

# copy new compiled version of ffmpeg to /usr/local/bin
#sudo cp ~/jetson-ffmpeg/build/ffmpeg/ffmpeg /usr/local/bin/
sudo make install
