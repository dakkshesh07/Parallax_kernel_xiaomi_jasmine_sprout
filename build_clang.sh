clear

## Copy this script inside the kernel directory

echo checking for repo update
git config pull.rebase false
git pull

if [ -r clang ]; then
  echo clang found! check for update...
  cd clang
  git config pull.rebase false
  git pull
  cd ..

else
  echo clang not found!, git cloning it now....
  git clone https://github.com/kdrag0n/proton-clang.git clang

fi

ANYKERNEL3_DIR=$PWD/anykernel/

GREEN="\033[01;32m"
RST="\033[0m"

RED="\033[01;32m"
NC="\033[0m"

echo "${GREEN}cleaning old files${RST}"

echo "**** Removing leftovers ****"
rm -rf $ANYKERNEL3_DIR/Image.gz-dtb
rm -rf $ANYKERNEL3_DIR/dtbo.img
rm -rf $ANYKERNEL3_DIR/Parallax_Kernel.zip
rm -rf out

make clean && make distclean && make mrproper

mkdir -p out



echo "${GREEN}copying needed tools from compiler-tools${RST}"

echo "${GREEN}starting build now, go have a cup coffee or tea${RST}"

sleep 5

make O=out ARCH=arm64 parallax_defconfig

PATH="${PWD}/clang/bin:${PATH}" \
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC=clang \
                      CROSS_COMPILE=aarch64-linux-gnu- \
                      CROSS_COMPILE_ARM32=arm-linux-gnueabi- \
                      LLVM="llvm-" \
                      AR=llvm-ar \
                      NM=llvm-nm \
                      OBJCOPY=llvm-objcopy \
                      OBJDUMP=llvm-objdump \
                      STRIP=llvm-strip



  if [ -f out/arch/arm64/boot/Image.gz-dtb ]; then

    cp out/arch/arm64/boot/Image.gz-dtb anykernel
    cd anykernel
      
    sudo zip -r9 Parallax_Kernel.zip .


    cd ..

    echo "${GREEN}zip file made!${RST}"
    echo "${GREEN}check your zipped file in anykernel folder!${RST}"
    echo "${GREEN}finished...... bye!${RST}"

    else
      echo "${RED}build failed${NC}"
    fi

echo "script ended"