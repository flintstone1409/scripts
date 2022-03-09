git clone https://github.com/jocover/jetson-ffmpeg.git && \
    cd jetson-ffmpeg && \
    git checkout 7baa3d8 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    sudo make install && \
    sudo ldconfig && \
    git clone git://source.ffmpeg.org/ffmpeg.git -b release/4.2 --depth=1 && \
    cd ffmpeg && \
    cp ../../ffmpeg_nvmpi.patch . && \
    git apply ffmpeg_nvmpi.patch && \
    ./configure --enable-nvmpi && \
    make && \
    sudo make install
