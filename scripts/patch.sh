#!/usr/bin/env bash

FILE_NAME=$1
FILE=$FILE_NAME.AppImage
DIST_FILE=$FILE_NAME-patched.AppImage
TMP_DIR=/tmp/$FILE
PATCHED_DIR=$TMP_DIR-patched

mkdir $TMP_DIR
sudo mount -o loop $FILE $TMP_DIR
cp -r $TMP_DIR $PATCHED_DIR
sudo unmount $TMP_DIR
rm -rf $TMP_DIR

./bin/navicat-patcher $PATCHED_DIR

wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage
chmod +x appimagetool-x86_64.AppImage
./appimagetool-x86_64.AppImage $PATCHED_DIR $DIST_FILE
chmod +x $DIST_FILE
rm appimagetool-x86_64.AppImage
rm -rf $PATCHED_DIR
