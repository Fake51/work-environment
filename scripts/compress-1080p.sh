#!/bin/sh

if [ ! -f "$1" ]
then
    echo "No such file: $1"

    exit 1
fi

NEWNAME=`echo "$1" | sed -r 's/^(.*)\.[^.]+$/\1.mp4/'`

ffmpeg -i "$1" -codec:v libx264 -profile:v high -preset slow -crf 20 -vf scale=-1:1080 -threads 0 -codec:a libfdk_aac -b:a 128k -f mp4 "$NEWNAME"
