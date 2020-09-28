echo kernel clompiler for android by dakkshesh

echo Lets start....

echo cleaning old files

rm -rf out

make clean && make distclean && make mrproper

mkdir -p out

make O=out ARCH=arm64 wayne_defconfig

echo building

export CROSS_COMPILE=/home/dakkshesh/Desktop/kernel/64bit/bin/aarch64-linux-android- 
export CROSS_COMPILE_ARM32=/home/dakkshesh/Desktop/kernel/32bit/bin/arm-linux-androideabi-
export ARCH=arm64
export SUBARCH=arm64
export CLANG_TRIPLE=aarch64-linux-android-
export LLVM="llvm-"
export AR=llvm-ar
export NM=llvm-nm
export OBJCOPY=llvm-objcopy
export OBJDUMP=llvm-objdump
export STRIP=llvm-strip

PATH=$/home/dakkshesh/Desktop/kernel/proton/proton-clang/bin$PATH
#PATH=$/home/dakkshesh/Desktop/kernel/64bit/bin$PATH
#PATH=$/home/dakkshesh/Desktop/kernel/32bit/bin$PATH
export PATH=$/home/dakkshesh/Desktop/kernel/proton/proton-clang/bin$PATH
#make O=out menuconfig
make -j$(nproc --all) O=out 

echo finished.... bye                   