#!/bin/bash
# =================================================
# Build script for Ubuntu Touch on Realme 7
# Device  : Realme 7 (salaa / RMX2163)
# Android : 12 (S)
# Halium  : 12.0
# Chipset : MediaTek Helio G95 (MT6853)
# =================================================

set -e

source halium.env
cd $ANDROID_ROOT

echo "================================================="
echo " Ubuntu Touch HAL Builder"
echo " Device  : Realme 7 (salaa / RMX2163)"
echo " Android : 12 (S)"
echo " Halium  : 12.0"
echo " Cores   : $(nproc)"
echo "================================================="

# تهيئة بيئة البناء
source build/envsetup.sh

# تطبيق Halium patches
echo ">>> Applying hybris patches..."
bash hybris-patches/apply-patches.sh --mb

# تفعيل ccache لتسريع البناء
export USE_CCACHE=1
export CCACHE_DIR=$ANDROID_ROOT/.ccache
export CCACHE_EXEC=$(which ccache)
ccache -M 10G

# اختيار الجهاز
echo ">>> Setting up breakfast for $DEVICE..."
breakfast $DEVICE

# البناء خطوة بخطوة
echo ">>> Building mkbootimg..."
make -j$(nproc) mkbootimg

echo ">>> Building fec..."
make -j$(nproc) fec

echo ">>> Building halium-boot.img..."
make -j$(nproc) halium-boot

echo ">>> Building system.img..."
make -j$(nproc) systemimage

echo ">>> Building vendor.img..."
make -j$(nproc) vendorimage

# النتائج النهائية
echo ""
echo "================================================="
echo " ✅ Build Complete!"
echo "================================================="
ls -lh $ANDROID_ROOT/out/target/product/$DEVICE/*.img 2>/dev/null
echo ""
echo " MD5 Checksums:"
md5sum $ANDROID_ROOT/out/target/product/$DEVICE/halium-boot.img || true
md5sum $ANDROID_ROOT/out/target/product/$DEVICE/system.img      || true
md5sum $ANDROID_ROOT/out/target/product/$DEVICE/vendor.img      || true
echo "================================================="
