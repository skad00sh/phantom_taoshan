#!/bin/bash
TOOLCHAIN="/home/shivam/development/toolchains/arm-cortex-a15/bin/arm-cortex_a15-linux-gnueabihf"
MODULES_DIR="../modules"
ZIMAGE="/home/shivam/development/kernel/arch/arm/boot/zImage"
KERNEL_DIR="/home/shivam/development/kernel"
if [ -a $KERNEL_DIR/arch/arm/boot/zImage ];
then
rm $ZIMAGE
rm $MODULES_DIR/*
fi
make ARCH=arm CROSS_COMPILE=$TOOLCHAIN- sa77-kk_defconfig
make ARCH=arm CROSS_COMPILE=$TOOLCHAIN- -j8
if [ -a $KERNEL_DIR/arch/arm/boot/zImage ];
then
echo "Copying modules"
rm $MODULES_DIR/*
find . -name '*.ko' -exec cp {} $MODULES_DIR/ \;
cd $MODULES_DIR
echo "Stripping modules for size"
$TOOLCHAIN-strip --strip-unneeded *.ko
cd $KERNEL_DIR
else
echo "Compilation failed! Fix the errors!"
fi
