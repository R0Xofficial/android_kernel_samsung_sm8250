#!/bin/bash
set -e

echo "Entering main directory..."
cd ~/android_kernel_samsung_sm8250
echo "Done!"
echo "Synchronizing repository..."
git pull
echo "Done!"
echo "Deleting old 'out' folder..."
rm -rf out
echo "Done!"
echo "Fixing ratelimit headers..."
sed -i '/#include <linux\/spinlock_types.h>/d' include/linux/ratelimit_types.h
sed -i '/struct raw_spinlock;/d' include/linux/ratelimit_types.h
sed -i '1i #include <linux/spinlock_types.h>' include/linux/ratelimit_types.h
echo "Done!"
echo "Setting environment variables..."
export LLVM_IAS=1
export KCFLAGS="-Wno-error -Wno-gnu-variable-sized-type-not-at-end -Wno-unused-command-line-argument"
echo "Done!"
echo "Starting build kernel..."
./build_kona_kernel.sh
echo "Done!"
echo "Gzipping kernel Image..."
gzip -5 -c ~/android_kernel_samsung_sm8250/out/Image > ~/android_kernel_samsung_sm8250/out/Image.gz
sleep 1
echo "Done!"
echo "Removing old kernel files in Windows..."
rm -f /mnt/c/Users/MSI/Desktop/r8q/Image.gz
rm -f /mnt/c/Users/MSI/Desktop/r8q/Image
rm -f /mnt/c/Users/MSI/Desktop/r8q/dtb
rm -f /mnt/c/Users/MSI/Desktop/r8q/dtbo.img
echo "Done!"
echo "Copying new kernel files to Windows..."
cp ~/android_kernel_samsung_sm8250/out/Image.gz /mnt/c/Users/MSI/Desktop/r8q/Image.gz
cp ~/android_kernel_samsung_sm8250/out/Image /mnt/c/Users/MSI/Desktop/r8q/Image
cp ~/android_kernel_samsung_sm8250/out/dtb.img /mnt/c/Users/MSI/Desktop/r8q/dtb
cp ~/android_kernel_samsung_sm8250/out/dtbo.img /mnt/c/Users/MSI/Desktop/r8q/dtbo.img
echo "Done!"
echo "Kernel is ready!"
