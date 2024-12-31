#!/bin/bash
set -e

if [ "$1" == "--uninstall" ]; then
    echo -e "\033[32mRemoving ~/.tools and /etc/paths.d/tools...\033[0m"
    rm -rf ~/.tools
    sudo rm -f /etc/paths.d/tools

    echo -e "\033[32mCleaning up temporary files...\033[0m"
    rm -rf temp

    echo -e "\033[32mUninstallation complete!\033[0m"
    exit 0
fi

mkdir ~/.tools
mkdir temp

echo -e "\033[32mInstalling dependencies...\033[0m"
brew install cmake libcrypto libpng openssl

echo -e "\033[32mCloning xpwn...\033[0m"
git clone https://github.com/Kaiden-AC/xpwn.git temp/xpwn

echo -e "\033[32mBuilding xpwn...\033[0m"
cd temp/xpwn
mkdir xpwn-build
cd xpwn-build
cmake ..
make
mv dmg/dmg hfs/hfsplus ipsw-patch/xpwntool ~/.tools
cd ../..

echo -e "\033[32mCloning iBoot32Patcher...\033[0m"
git clone https://github.com/dora2ios/iBoot32Patcher.git temp/iBoot32Patcher

echo -e "\033[32mBuilding iBoot32Patcher...\033[0m"
cd temp/iBoot32Patcher
clang iBoot32Patcher.c finders.c functions.c patchers.c -Wno-multichar -Wno-int-conversion -I. -o iBoot32Patcher
mv iBoot32Patcher ~/.tools
cd ../..

echo -e "\033[32mCloning image3maker...\033[0m"
git clone https://github.com/darwin-on-arm/image3maker.git temp/image3maker

echo -e "\033[32mBuilding image3maker...\033[0m"
cd temp/image3maker
make
mv image3maker ~/.tools
cd ../..

echo -e "\033[32mCloning ipwnder_lite...\033[0m"
git clone --recursive https://github.com/dora2ios/ipwnder_lite.git temp/ipwnder_lite

echo -e "\033[32mBuilding ipwnder_lite...\033[0m"
cd temp/ipwnder_lite
make
mv ipwnder_macosx ~/.tools
cd ../..

echo -e "\033[32mInstalling libirecovery...\033[0m"
brew install libirecovery

echo -e "\033[32mAdding ~/.tools to system path...\033[0m"
echo "/Users/$(whoami)/.tools" | sudo tee -a /etc/paths.d/tools > /dev/null

echo -e "\033[32mCleaning up temporary files...\033[0m"
rm -rf temp

echo -e "\033[32mFinished!\033[0m"
