#!/bin/bash
set -e
trap 'echo [error] Command returned exit code 1' ERR
if [ ! $# = 1 ]; then
	echo makeIcns version:1 author:CoreNion
	echo Usage: makeicns.sh [image_in]
	exit
elif [[ ! -e $1 ]]; then
	echo [error] File is not found.
	exit 1
elif !(type sips > /dev/null 2>&1); then
	echo [error] Sips is not installed.
	exit 1
fi
echo makeIcns version:1 author:CoreNion
echo First, make required images.
filename=$(basename $1)
if [ -e ${filename}.iconset ]; then
	rm -rf ${filename}.iconset
fi
mkdir ${filename}.iconset
echo sips -Z 1024 -s dpiHeight 144.0 -s dpiWidth 144.0 $1 -o ${filename}.iconset/icon_512x512@2x.png
echo making 512x512@2 size....
sips -Z 1024 -s dpiHeight 144.0 -s dpiWidth 144.0 $1 -o ${filename}.iconset/icon_512x512@2x.png
echo Done.
echo making 512x512 size....
sips -Z 512 -s dpiHeight 72.0 -s dpiWidth 72.0 $1 -o ${filename}.iconset/icon_512x512.png 
echo Done.
echo Making 256x256@2 size....
sips -Z 512 -s dpiHeight 144.0 -s dpiWidth 144.0 $1 -o ${filename}.iconset/icon_256x256@2x.png
echo Done.
echo Making 256x256 size....
sips -Z 256 -s dpiHeight 72.0 -s dpiWidth 72.0 $1 -o ${filename}.iconset/icon_256x256.png 
echo Done.
echo Making 128x128@2 size....
sips -Z 256 -s dpiHeight 144.0 -s dpiWidth 144.0 $1 -o ${filename}.iconset/icon_128x128@2x.png
echo Done.
echo Making 128x128 size....
sips -Z 128 -s dpiHeight 72.0 -s dpiWidth 72.0 $1 -o ${filename}.iconset/icon_128x128.png
echo Done.
echo Making 32x32@2x size....
sips -Z 64 -s dpiHeight 144.0 -s dpiWidth 144.0 $1 -o ${filename}.iconset/icon_32x32@2x.png
echo Done.
echo Making 32x32 size....
sips -Z 32 -s dpiHeight 72.0 -s dpiWidth 72.0 $1 -o ${filename}.iconset/icon_32x32.png
echo Done.
echo Making 16x16@2x size....
sips -Z 32 -s dpiHeight 144.0 -s dpiWidth 144.0 $1 -o ${filename}.iconset/icon_16x16@2x.png
echo Done.
echo Making 16x16 size....
sips -Z 16 -s dpiHeight 72.0 -s dpiWidth 72.0 $1 -o ${filename}.iconset/icon_16x16.png
echo Done.
echo Making icns......
iconutil -c icns ${filename}.iconset
echo Succeeded in making icns!
exit 0
