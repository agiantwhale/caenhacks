#!/usr/bin/env bash

SOURCE_DIR="/tmp/source"
PREFIX_DIR="$HOME/scsusr"

rm -rf $SOURCE_DIR
mkdir -p $SOURCE_DIR
mkdir -p $PREFIX_DIR

# (cd "$SOURCE_DIR" && curl -L -O "http://mirrors.concertpass.com/gcc/releases/gcc-5.2.0/gcc-5.2.0.tar.bz2")
# (cd "$SOURCE_DIR" && tar -xvf "gcc-5.2.0.tar.bz2")
# (cd "$SOURCE_DIR" && ./gcc-5.2.0/contrib/download_prerequisites)
# (mkdir -p "$SOURCE_DIR/gccbuild")
# (cd "$SOURCE_DIR/gccbuild" && $PWD/../gcc-5.2.0/configure --prefix=$PREFIX_DIR --enable-languages=c,c++)
# (cd "$SOURCE_DIR/gccbuild" && make -j10 && make install)

(cd "$SOURCE_DIR" && curl -O -L "https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tar.xz")
(cd "$SOURCE_DIR" && tar -xvf "Python-2.7.10.tar.xz")
(cd "$SOURCE_DIR/Python-2.7.10" && ./configure --prefix=$PREFIX_DIR --enable-shared --with-system-expat --with-system-ffi --enable-unicode=ucs4)
(cd "$SOURCE_DIR/Python-2.7.10" && make -j10 && make install && chmod -v 755 $PREFIX_DIR/lib/libpython2.7.so.1.0)

(cd "$SOURCE_DIR" && curl -O -L "https://bootstrap.pypa.io/get-pip.py")
(cd "$SOURCE_DIR" && $PREFIX_DIR/bin/python2.7 get-pip.py)

(cd "$SOURCE_DIR" && curl -L -o "boost_1_59_0.tar.bz2" "http://sourceforge.net/projects/boost/files/boost/1.59.0/boost_1_59_0.tar.bz2/download")
(cd "$SOURCE_DIR" && tar -xvf "boost_1_59_0.tar.bz2")
(cd "$SOURCE_DIR/boost_1_59_0" && ./bootstrap.sh --prefix=$PREFIX_DIR)
(cd "$SOURCE_DIR/boost_1_59_0" && ./b2 -j10 install)

git clone https://github.com/Kitware/CMake.git "$SOURCE_DIR/cmake"
(cd "$SOURCE_DIR/cmake" && git checkout release)
(cd "$SOURCE_DIR/cmake" && ./configure --prefix=$PREFIX_DIR)
(cd "$SOURCE_DIR/cmake" && make -j10 && make install)

git clone https://github.com/yasm/yasm.git "$SOURCE_DIR/yasm"
mkdir -p "$SOURCE_DIR/yasmbuild"
(cd "$SOURCE_DIR/yasmbuild" && $PREFIX_DIR/bin/cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=$PREFIX_DIR -D CMAKE_PREFIX_PATH=$PREFIX_DIR ../yasm)
(cd "$SOURCE_DIR/yasmbuild" && make -j10 && make install)

git clone git://git.videolan.org/x264.git "$SOURCE_DIR/x264"
(cd "$SOURCE_DIR/x264" && ./configure --prefix=$PREFIX_DIR --enable-static --enable-shared --enable-pic)
(cd "$SOURCE_DIR/x264" && make -j10 && make install)

git clone https://github.com/FFmpeg/FFmpeg.git "$SOURCE_DIR/ffmpeg"
(cd "$SOURCE_DIR/ffmpeg" && PKG_CONFIG_PATH="$PREFIX_DIR/lib/pkgconfig" ./configure --extra-ldflags=-L$PREFIX_DIR/lib --extra-cflags=-I$PREFIX_DIR/include --prefix=$PREFIX_DIR --enable-avresample --enable-gpl --enable-libx264 --enable-postproc --enable-version3 --enable-x11grab --enable-shared --enable-pic)
(cd "$SOURCE_DIR/ffmpeg" && make -j10 && make install)

(cd "$SOURCE_DIR" && $PREFIX_DIR/bin/pip install numpy)
(cv "$SOURCE_DIR/cv" && git checkout 2.4)
mkdir -p "$SOURCE_DIR/cvbuild"
(cd "$SOURCE_DIR/cvbuild" && PKG_CONFIG_PATH="$PREFIX_DIR/lib/pkgconfig" $PREFIX_DIR/bin/cmake \
  -D CMAKE_BUILD_TYPE=RELEASE \
  -D CMAKE_INSTALL_PREFIX=$PREFIX_DIR \
  -D CMAKE_PREFIX_PATH=$PREFIX_DIR \
  -D BUILD_NEW_PYTHON_SUPPORT=ON \
  -D PYTHON2_EXECUTABLE=$PREFIX_DIR/bin/python2.7 \
  -D PYTHON2_INCLUDE=$PREFIX_DIR/include/python2.7/ \
  -D PYTHON2_LIBRARIES=$PREFIX_DIR/lib/libpython2.7.so.1.0 \
  -D PYTHON2_PACKAGES_PATH=$PREFIX_DIR/lib/python2.7/site-packages/ \
  -D PYTHON2_NUMPY_INCLUDE_DIRS=$PREFIX_DIR/python2.7/site-packages/numpy/core/include \
  -D WITH_IPP=OFF \
  -D WITH_GTK=OFF \
  -D WITH_V4L=OFF \
  -D BUILD_ZLIB=TRUE \
  -D BUILD_TIFF=TRUE \
  -D BUILD_JASPER=TRUE \
  -D BUILD_JPEG=TRUE \
  -D BUILD_PNG=TRUE \
  -D BUILD_OPENEXR=TRUE \
  -D BUILD_TBB=TRUE \
  ../cv)
(cd "$SOURCE_DIR/cvbuild" && make -j10 && make install)
