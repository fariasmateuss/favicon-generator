#!/bin/bash
SRC_IMAGE=$1

CYAN='\033[0;36m'
RED='\033[0;31m'
COLORRESET='\033[0m'

declare -a SIZES
declare -a GENERATED
declare -a ICONS
declare -a SIZES_APPLE
declare -a GENERATED_APPLE

if ! command -v convert >/dev/null 2>&1; then
    echo -e "${RED}ImageMagick is not installed.${COLORRESET}"
    exit 1
fi

if [ -z "$SRC_IMAGE" ]; then
    echo -ne "${RED}You must supply a source image as the argument to this command. \n${COLORRESET}"
    exit 1
fi

if [ ! -f "$SRC_IMAGE" ]; then
    echo -ne "${RED}Source image \"$SRC_IMAGE\" does not exist. \n${COLORRESET}"
    exit 1
fi

NAME="${SRC_IMAGE/\.*/-512x512.png}"
echo -ne "${CYAN}Generating square base image \n${COLORRESET}"
convert "$SRC_IMAGE" -resize 512x512! -transparent white "${NAME}"

SIZES=("16x16" "32x32" "64x64" "96x96" "128x128" "256x256")

echo -ne "${CYAN}Generating favicons \n${COLORRESET}"
for i in "${SIZES[@]}"; do 
	: "$NAME"
	convert "$_" -resize "${i}" "${_/512x512\.png/$i\.png}"
	ICONS+=("$_")
done

echo -ne "${CYAN}Generating ico \n${COLORRESET}"
convert "${ICONS[@]:0:4}" -colors 256 favicon.ico

GENERATED=("${ICONS[@]}")
ICONS=()
SIZES_APPLE=("152x152" "167x167" "180x180")

echo -ne "${CYAN}Generating touch icons \n${COLORRESET}"
for i in "${SIZES_APPLE[@]}"; do 
	: "$NAME"
	convert "$_" -resize "${i}" "${_/512x512.png/apple-touch-icon-$i\.png}"
	ICONS+=("$_")
done

GENERATED_APPLE=("${ICONS[@]}")

if [[ $2 == "-x" ]]; then
	count=0

	: > favicons.txt

	echo -ne "${CYAN}Create html tags in favicons.txt \n${COLORRESET}"

	for i in "${GENERATED[@]}"; do
		echo "<link rel=\"shortcut icon\" type=\"image/png\" sizes=\"${SIZES[count]}\" href=\"${i}\" />" >> favicons.txt
		count=$((count+1))
	done

	count=0
	for i in "${GENERATED_APPLE[@]}"; do
		echo "<link rel=\"apple-touch-icon\" type=\"image/png\" sizes=\"${SIZES_APPLE[count]}\" href=\"${i}\" />" >> favicons.txt
		count=$((count+1))
	done
fi
