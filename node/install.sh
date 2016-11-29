#!/bin/bash

TARGET=`curl -s https://nodejs.org/en/download/current/ | grep linux-x64 | sed 's/^.*https/https/' | sed 's/".*$//'`
FILE=`basename "$TARGET"`
wget $TARGET
tar -xvf $FILE

DIR=`ls -l | grep '^d' | awk '{print $9}'`

sudo cp $DIR/bin/node /usr/local/bin/

mkdir ~/.npm-global
$DIR/bin/npm config set prefix '~/.npm-global'
$DIR/bin/npm install -g npm

rm -rf $DIR
rm $FILE

npm -g i n
sudo ~/.npm-global/bin/n stable
