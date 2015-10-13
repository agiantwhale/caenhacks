#!/usr/bin/env bash

SOURCE_DIR="/tmp/source"
PREFIX_DIR="$HOME/usr"

rm -rf $SOURCE_DIR
mkdir -p $SOURCE_DIR
mkdir -p $PREFIX_DIR

(cd "$SOURCE_DIR" && curl -L -O -J "http://mirrors.concertpass.com/gcc/releases/gcc-5.2.0/gcc-5.2.0.tar.bz2")
(cd "$SOURCE_DIR" && tar -xvf "gcc-5.2.0.tar.bz2")
(cd "$SOURCE_DIR" && ./gcc-5.2.0/contrib/download_prerequisites)
(mkdir -p "$SOURCE_DIR/gccbuild")
(cd "$SOURCE_DIR/gccbuild" && $PWD/../gcc-5.2.0/configure --prefix=$PREFIX_DIR --enable-languages=c,c++)
(cd "$SOURCE_DIR/gccbuild" && make -j10 && make install)

git clone https://github.com/boostorg/boost.git "$SOURCE_DIR/boost"
(cd "$SOURCE_DIR/boost" && ./bootstrap.sh --prefix=$PREFIX_DIR)
(cd "$SOURCE_DIR/boost" && ./b2 -j10 install)

git clone https://github.com/Kitware/CMake.git "$SOURCE_DIR/cmake"
(cd "$SOURCE_DIR/cmake" && git checkout release)
(cd "$SOURCE_DIR/cmake" && ./configure --prefix=$PREFIX_DIR)
(cd "$SOURCE_DIR/cmake" && make -j10 && make install)

git clone https://github.com/yasm/yasm.git "$SOURCE_DIR/yasm"
mkdir -p "$SOURCE_DIR/yasmbuild"
(cd "$SOURCE_DIR/yasmbuild" && cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=$PREFIX_DIR -D CMAKE_PREFIX_PATH=$PREFIX_DIR ../yasm)
(cd "$SOURCE_DIR/yasmbuild" && make -j10 && make install)

git clone git://git.videolan.org/x264.git "$SOURCE_DIR/x264"
(cd "$SOURCE_DIR/x264" && ./configure --prefix=$PREFIX_DIR --enable-static --enable-shared --enable-pic)
(cd "$SOURCE_DIR/x264" && make -j10 && make install)

git clone https://github.com/FFmpeg/FFmpeg.git "$SOURCE_DIR/ffmpeg"
(cd "$SOURCE_DIR/ffmpeg" && PKG_CONFIG_PATH="$PREFIX_DIR/lib/pkgconfig" ./configure --extra-ldflags=-L$PREFIX_DIR/lib --extra-cflags=-I$PREFIX_DIR/include --prefix=$PREFIX_DIR --enable-avresample --enable-gpl --enable-libx264 --enable-postproc --enable-version3 --enable-x11grab --enable-shared --enable-pic)
(cd "$SOURCE_DIR/ffmpeg" && make -j10 && make install)

git clone https://github.com/Itseez/opencv.git "$SOURCE_DIR/cv"
mkdir -p "$SOURCE_DIR/cvbuild"
(cd "$SOURCE_DIR/cvbuild" && PKG_CONFIG_PATH="$PREFIX_DIR/lib/pkgconfig" cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=$PREFIX_DIR -D CMAKE_PREFIX_PATH=$PREFIX_DIR -D WITH_IPP=OFF -D WITH_GTK=OFF -D WITH_V4L=OFF -D BUILD_ZLIB=TRUE -D BUILD_TIFF=TRUE -D BUILD_JASPER=TRUE -D BUILD_JPEG=TRUE -D BUILD_PNG=TRUE -D BUILD_OPENEXR=TRUE -D BUILD_TBB=TRUE ../cv)
(cd "$SOURCE_DIR/cvbuild" && make -j10 && make install)
