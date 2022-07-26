echo "===================Setup Export========================="
export ANYKERNEL_PATH=~/Anykernel3
export CLANG_PATH=~/prelude-clang
export PATH=${CLANG_PATH}/bin:${PATH}
export CLANG_TRIPLE=aarch64-linux-gnu-
export ARCH=arm64
export SUBARCH=arm64
echo "===================Setup Environment==================="
git clone --depth=1 https://github.com/kdrag0n/proton-clang -b 20210522 $CLANG_PATH  # https://gitlab.com/jjpprrrr/prelude-clang.git
git clone https://github.com/osm0sis/AnyKernel3 $ANYKERNEL_PATH
sh -c "$(curl -sSL https://github.com/akhilnarang/scripts/raw/master/setup/android_build_env.sh/)"
git submodule update --init --recursive
echo "=========================Clean========================="
make mrproper && git reset --hard HEAD
echo "=========================Build========================="
make O=out CC="ccache clang" CXX="ccache clang++" CROSS_COMPILE=$CLANG_PATH/bin/aarch64-linux-gnu- CROSS_COMPILE_ARM32=$CLANG_PATH/bin/arm-linux-gnueabi- gauguin_user_defconfig
make O=out CC="ccache clang" CXX="ccache clang++" CROSS_COMPILE=$CLANG_PATH/bin/aarch64-linux-gnu- CROSS_COMPILE_ARM32=$CLANG_PATH/bin/arm-linux-gnueabi- -j4 2>&1 | tee out/kernel.log

