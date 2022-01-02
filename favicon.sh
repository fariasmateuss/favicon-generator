#!/bin/bash
SRC_IMAGE=$1

# colors
CYAN='\033[0;36m'
RED='\033[0;31m'
COLORRESET='\033[0m'

// script to generate favicon.ico
if [ -z $SRC_IMAGE ]; then
    echo -ne "${RED}You must supply a source image as the argument to this command. \n${COLORRESET}"
    exit
fi

if [ ! -f $SRC_IMAGE ]; then
    echo -ne "${RED}Source image \"$SRC_IMAGE\" does not exist. \n${COLORRESET}"
    exit
fi

echo -ne "${CYAN}Generating square base image \n${COLORRESET}"
convert $SRC_IMAGE -resize 512x512! -transparent white favicon-512x512.png

echo -ne "${CYAN}Generating favicons \n${COLORRESET}"
convert favicon-512x512.png -resize 16x16 favicon-16x16.png
convert favicon-512x512.png -resize 32x32 favicon-32x32.png
convert favicon-512x512.png -resize 64x64 favicon-64x64.png
convert favicon-512x512.png -resize 96x96 favicon-96x96.png
convert favicon-512x512.png -resize 128x128 favicon-128x128.png
convert favicon-512x512.png -resize 256x256 favicon-256x256.png

echo -ne "${CYAN}Generating ico \n${COLORRESET}"
convert favicon-16x16.png favicon-32x32.png favicon-64x64.png favicon-96x96.png -colors 256 favicon.ico

echo -ne "${CYAN}Generating touch icons \n${COLORRESET}"
convert favicon-512x512.png -resize 152x152 apple-touch-icon-152x152.png
convert favicon-512x512.png -resize 167x167 apple-touch-icon-167x167.png
convert favicon-512x512.png -resize 180x180 apple-touch-icon.png