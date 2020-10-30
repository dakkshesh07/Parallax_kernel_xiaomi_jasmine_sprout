clear

echo kernel clompiler for android by dakkshesh

echo Lets start....

		if [ -r 64bit ]; then
			echo 64 bit gcc found! check for update....
			cd 64bit
			git pull
			cd ..

		else
			echo 64bit gcc not found!, git cloning it now....
			git clone https://github.com/arter97/arm64-gcc.git 64bit

		fi

		if [ -r 32bit ]; then
  			echo 32 bit gcc found! check for update...
  			cd 32bit
  			git pull
  			cd ..

  		else
  			echo 32bit gc not found! fetching it now
  			git clone https://github.com/arter97/arm32-gcc.git 32bit

  		fi
  		

ZIPNAME="DuskMane_Kernel"


GREEN="\033[01;32m"
RST="\033[0m"

RED="\033[01;32m"
NC="\033[0m"

TANGGAL=$(date +"%F-%S")





echo "**** Removing leftovers ****"
rm -rf $ANYKERNEL3_DIR/Image.gz-dtb
rm -rf $ANYKERNEL3_DIR/dtbo.img
rm -rf $ANYKERNEL3_DIR/DuskMane_Kernel.zip
rm -rf out


cd ..

if [ -f out/arch/arm64/boot/Image.gz-dtb ]; then
	echo "${RED}old images found!, cleaning now${NC}"
	cd anykernel
	rm Image.gz-dtb
	cd ..
	echo done
	echo "${GREEN}cleaning old files${RST}"
	make clean && make distclean && make mrproper

	mkdir -p out

	echo "${GREEN}starting build now, go have a cup coffee or tea${RST}"

	sleep 5

	make O=out ARCH=arm64 wayne_defconfig

	echo "${GREEN}building.....${RST}"
	

	export CROSS_COMPILE=$(pwd)/64bit/bin/aarch64-elf-
	export CROSS_COMPILE_ARM32=$(pwd)/32bit/bin/arm-eabi-
	export ARCH=arm64
	export SUBARCH=arm64
	export LLVM="llvm-"
	export AR=llvm-ar
	export NM=llvm-nm
	export OBJCOPY=llvm-objcopy
	export OBJDUMP=llvm-objdump
	export STRIP=llvm-strip

	
	make -j$(nproc --all) O=out

	
	echo "${GREEN}build finished, lets zip it up${RST}"

	if [ -f out/arch/arm64/boot/Image.gz-dtb ]; then

		cp out/arch/arm64/boot/Image.gz-dtb anykernel
	    cd anykernel
	    	    
	    sudo zip -r9 DuskMane_Kernel.zip .

	    cd ..
	    
	    echo "${GREEN}zip file made!${RST}"
	    echo "${GREEN}check your zipped file in anykernel folder!${RST}"

	else
		echo "${RED}build failed${NC}"
	fi

	echo finished.... bye

else

echo "${GREEN}cleaning old files${RST}"
	
make clean && make distclean && make mrproper


echo "${GREEN}making 'out' folder${RST}"

mkdir -p out

echo "${GREEN}starting build now, go have a cup coffee or tea${RST}"

sleep 5

make O=out ARCH=arm64 wayne_defconfig

echo "${GREEN}building.....${RST}"

export CROSS_COMPILE=$(pwd)/64bit/bin/aarch64-elf- 
export CROSS_COMPILE_ARM32=$(pwd)/32bit/bin/arm-eabi-
export ARCH=arm64
export SUBARCH=arm64
export CLANG_TRIPLE=aarch64-linux-android-
export LLVM="llvm-"
export AR=llvm-ar
export NM=llvm-nm
export OBJCOPY=llvm-objcopy
export OBJDUMP=llvm-objdump
export STRIP=llvm-strip


make -j$(nproc --all) O=out
echo "${GREEN}build finished, lets zip it up${RST}"

fi

	if [ -f out/arch/arm64/boot/Image.gz-dtb ]; then

		cp out/arch/arm64/boot/Image.gz-dtb anykernel
    	cd anykernel
    	
    	sudo zip -r9 DuskMane_Kernel.zip .


    	cd ..

    	echo "${GREEN}zip file made!${RST}"
    	echo "${GREEN}check your zipped file in anykernel folder!${RST}"

    else
    	echo "${RED}build failed${NC}"
    fi

echo "${GREEN}finished...... bye!${RST}"
echo thank you.....