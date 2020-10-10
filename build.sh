clear

echo kernel clompiler for android by dakkshesh

echo Lets start....

ZIPNAME="DuskMane_Kernel"


GREEN="\033[01;32m"
RST="\033[0m"

RED="\033[01;32m"
NC="\033[0m"

TANGGAL=$(date +"%F-%S")


rm -rf out
rm -rf anykernel

echo "${GREEN}copying needed tools for compiler-tools${RST}"

cd compiler-tools
cp -R anykernel $cd ..


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
	

	export CROSS_COMPILE=$(pwd)/64bit/bin/aarch64-linux-android- 
	export CROSS_COMPILE_ARM32=$(pwd)/32bit/bin/arm-linux-androideabi-
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

	if [ -f out/arch/arm64/boot/Image.gz-dtb ]; then

		cp out/arch/arm64/boot/Image.gz-dtb anykernel
	    cd anykernel
	    	    
	    sudo zip -r9 DuskMane_Kernel.zip .

	    cd ..0
	    
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

export CROSS_COMPILE=$(pwd)/64bit/bin/aarch64-linux-android- 
export CROSS_COMPILE_ARM32=$(pwd)/32bit/bin/arm-linux-androideabi-
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