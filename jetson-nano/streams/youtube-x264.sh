# Video
URL=https://www.youtube.com/watch?v=h3fUgOKFMNU # the URL of the video
URL=https://www.youtube.com/watch?v=QOjmvL3e7Lc
FORMAT=301 #272 # quality, in numbers given by youtube-dl -F

# Encoding
PRESET='veryfast'
BITRATE='6M' # for h264_nvmpi you need to put here half of the disired bitrate, seems to be some strange bug or something
# STREAM_URL='rtmp://a.rtmp.youtube.com/live2'
STREAM_URL='rtmp://fra02.contribute.live-video.net/app'
STREAM_KEY='live_0123456789abcdefxyz' # twitch stream key

ffmpeg -i $(youtube-dl -f $FORMAT -g $URL) \
-i $(youtube-dl -f $FORMAT -g $URL) \
-c:v libx264 -preset $PRESET -vf scale=1920:1080 -b:v $BITRATE -minrate $BITRATE -maxrate $BITRATE -bufsize 1M \
-c:a aac -strict experimental \
-f flv $STREAM_URL/$STREAM_KEY
