#!/bin/sh -x

# OS specific
echo "##### checking for os... targetos $targetos"
targetos=`uname -s`
bindir="binary"

cd ../
echo ""
echo "##### libav configure for emulator"
if [ ! -e ${bindir} ];
then
	mkdir ${bindir}
fi
emul_suffix="-emul"
append_configure=""

case $targetos in
Linux*)
;;
MINGW*)
append_configure="--enable-memalign-hack"
;;
Darwin*)
append_configure="--cc=cc --extra-cflags=-mmacosx-version-min=10.4"
;;
esac

./configure \
 --prefix=${bindir} --arch=x86 --build-suffix=${emul_suffix} \
 --disable-static --enable-shared --enable-pic --enable-optimizations \
 --disable-gpl --disable-doc --disable-avserver --disable-avplay --disable-avconv --disable-avprobe \
 --disable-everything --disable-network \
 --enable-encoder=aac --enable-encoder=h263 --enable-encoder=h263p \
 --enable-encoder=mpeg4 --enable-encoder=msmpeg4v2 --enable-encoder=msmpeg4v3 \
 --enable-decoder=aac --enable-decoder=mp3 --enable-decoder=mp3adu \
 --enable-decoder=wmav1 --enable-decoder=wmav2 \
 --enable-decoder=h263 --enable-decoder=h264 --enable-decoder=mpeg4 \
 --enable-decoder=msmpeg4v1 --enable-decoder=msmpeg4v2 --enable-decoder=msmpeg4v3 \
 --enable-decoder=wmv3 --enable-decoder=vc1 ${append_configure}
