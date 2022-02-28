#!/usr/bin/env bash

FILE_NAME=$1
FILE=$FILE_NAME.AppImage
DIST_FILE=$FILE_NAME-patched.AppImage
TMP_DIR=/tmp/$FILE
PATCHED_DIR=$TMP_DIR-patched

mkdir $TMP_DIR
sudo mount -o loop $FILE $TMP_DIR
cp -r $TMP_DIR $PATCHED_DIR
sudo umount $TMP_DIR
rm -rf $TMP_DIR

./bin/navicat-patcher $PATCHED_DIR

# patch glib2
wget -q https://archive.archlinux.org/packages/g/glib2/glib2-2.68.4-1-x86_64.pkg.tar.zst
tar xvf glib2-2.68.4-1-x86_64.pkg.tar.zst -C $PATCHED_DIR
rm glib2-2.68.4-1-x86_64.pkg.tar.zst

# patch libffi
wget -q https://archive.archlinux.org/packages/l/libffi/libffi-3.3-4-x86_64.pkg.tar.zst
tar xvf libffi-3.3-4-x86_64.pkg.tar.zst -C $PATCHED_DIR
rm libffi-3.3-4-x86_64.pkg.tar.zst

# patch glibc
wget -q https://archive.archlinux.org/packages/g/glibc/glibc-2.35-1-x86_64.pkg.tar.zst
tar xvf glibc-2.35-1-x86_64.pkg.tar.zst -C $PATCHED_DIR
rm glibc-2.35-1-x86_64.pkg.tar.zst

wget -q https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage
chmod +x appimagetool-x86_64.AppImage
./appimagetool-x86_64.AppImage $PATCHED_DIR $DIST_FILE
chmod +x $DIST_FILE
rm appimagetool-x86_64.AppImage
rm -rf $PATCHED_DIR
