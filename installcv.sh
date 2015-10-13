#!/usr/bin/env bash

SOURCE_DIR="/tmp/source"
LIB_DIR="$HOME/usr"

rm -rf $SOURCE_DIR
mkdir -p $SOURCE_DIR
mkdir -p $LIB_DIR

git clone https://github.com/yasm/yasm.git "$SOURCE_DIR/yasm"
mkdir -p "$SOURCE_DIR/yasmbuild"
(cd "$SOURCE_DIR/yasmbuild" && cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=$LIB_DIR -D CMAKE_PREFIX_PATH=$LIB_DIR ../yasm)
(cd "$SOURCE_DIR/yasmbuild" && make -j7 && make install)

git clone git://git.videolan.org/x264.git "$SOURCE_DIR/x264"
(cd "$SOURCE_DIR/x264" && ./configure --prefix=$LIB_DIR --enable-static --enable-shared --enable-pic)
(cd "$SOURCE_DIR/x264" && make -j7 && make install)

git clone https://github.com/FFmpeg/FFmpeg.git "$SOURCE_DIR/ffmpeg"
(cd "$SOURCE_DIR/ffmpeg" && PKG_CONFIG_PATH="$LIB_DIR/lib/pkgconfig" ./configure --extra-ldflags=-L$LIB_DIR/lib --extra-cflags=-I$LIB_DIR/include --prefix=$LIB_DIR --enable-avresample --enable-gpl --enable-libx264 --enable-postproc --enable-version3 --enable-x11grab --enable-shared --enable-pic)
(cd "$SOURCE_DIR/ffmpeg" && make -j7 && make install)

git clone https://github.com/Itseez/opencv.git "$SOURCE_DIR/cv"
mkdir -p "$SOURCE_DIR/cvbuild"
(cd "$SOURCE_DIR/cvbuild" && PKG_CONFIG_PATH="$LIB_DIR/lib/pkgconfig" cmake -D CMAKE_BUILD_TYPE=RELEASE -D WITH_GTK=OFF -D WITH_V4L=OFF -D BUILD_ZLIB=TRUE -D BUILD_TIFF=TRUE -D BUILD_JASPER=TRUE -D BUILD_JPEG=TRUE -D BUILD_PNG=TRUE -D BUILD_OPENEXR=TRUE -D BUILD_TBB=TRUE -D CMAKE_INSTALL_PREFIX=$LIB_DIR -D CMAKE_PREFIX_PATH=$LIB_DIR ../cv)
(cd "$SOURCE_DIR/cvbuild" && make -j7 && make install)
