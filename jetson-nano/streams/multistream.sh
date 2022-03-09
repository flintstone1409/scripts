# Video
URL=https://www.youtube.com/watch?v=h3fUgOKFMNU # the URL of the video
URL=https://www.youtube.com/watch?v=QOjmvL3e7Lc
FORMAT=301 #272 # quality, in numbers given by youtube-dl -F
OWIDTH=960
OHEIGHT=540

URL1=$URL
URL2=$URL
URL3=$URL
URL4=$URL
FORMAT1=$FORMAT
FORMAT2=$FORMAT
FORMAT3=$FORMAT
FORMAT4=$FORMAT

# Encoding
PRESET='ultrafast'
BITRATE='30M' # for h264_nvmpi you need to put here half of the disired bitrate, seems to be some strange bug or something
STREAM_URL='rtmp://a.rtmp.youtube.com/live2' # youtube streaming server
STREAM_KEY='put-your-stream-key-here' # youtube stream key
# STREAM_URL='rtmp://fra02.contribute.live-video.net/app' # Twitch server
# STREAM_KEY='live-0123456789abcdefxyz' # twitch stream key

ffmpeg \
-i $(youtube-dl -f $FORMAT1 -g $URL1) \
-i $(youtube-dl -f $FORMAT2 -g $URL2) \
-i $(youtube-dl -f $FORMAT3 -g $URL3) \
-i $(youtube-dl -f $FORMAT4 -g $URL4) \
-filter_complex "[0:v][1:v][2:v][3:v]xstack=inputs=4:layout=0_0|w0_0|0_h0|w0_h0[v]" -map "[v]" \
-c:v libx264 -preset $PRESET -b:v $BITRATE -minrate $BITRATE -maxrate $BITRATE -bufsize 1M \
-c:a aac -strict experimental \
-f flv $STREAM_URL/$STREAM_KEY
