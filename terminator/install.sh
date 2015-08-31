#!/bin/bash
DIR=`dirname $0`
DESTINATION=~/.config/terminator/

if [ ! -d $DESTINATION ]
then
    mkdir -p $DESTINATION
fi

cp $DIR/config $DESTINATION

DESTINATION=~/.fonts/

cd /tmp/
git clone https://github.com/chrissimpkins/Hack.git
cd Hack/build/ttf
cp * $DESTINATION
