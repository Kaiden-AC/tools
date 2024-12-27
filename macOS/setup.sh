#!/bin/bash

set -e

echo -e "\033[34mWould you like to proceed installing dmgtool, gaster, hfsplus, iBoot32Patcher, img4lib, img4tool, ipwnder_lite, libirecovery, kairos, libgeneral, libpartialzip, partialZipBrowser, sepless, seprmvr64, seprmvr64lite, tsschecker and xpwntool? (y/n)\033[0m"
read -r response
if [[ "$response" != "y" ]]; then
    echo "Installation aborted."
    exit 1
fi

mkdir ~/.tools
mkdir temp

echo -e "\033[32mInstalling dependencies...\033[0m"
brew install libcrippy libpng libplist openssl

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

echo -e "\033[32mCloning gaster...\033[0m"
git clone https://github.com/0x7ff/gaster.git temp/gaster

echo -e "\033[32mBuilding gaster...\033[0m"
cd temp/gaster
make
mv gaster ~/.tools
cd ../..

echo -e "\033[32mCloning iBoot32Patcher...\033[0m"
git clone https://github.com/dora2ios/iBoot32Patcher.git temp/iBoot32Patcher

echo -e "\033[32mBuilding iBoot32Patcher...\033[0m"
cd temp/iBoot32Patcher
gcc iBoot32Patcher.c finders.c functions.c patchers.c -Wno-multichar -I. -o iBoot32Patcher
mv iBoot32Patcher ~/.tools
cd ../..

echo -e "\033[32mCloning img4lib...\033[0m"
git clone --recursive https://github.com/xerub/img4lib.git temp/img4lib

echo -e "\033[32mBuilding img4lib...\033[0m"
cd temp/img4lib/lzfse
make
cd ..
make
mv img4 ~/.tools
cd ../..

echo -e "\033[32mCloning libgeneral...\033[0m"
git clone https://github.com/tihmstar/libgeneral.git temp/libgeneral

echo -e "\033[32mBuilding libgeneral...\033[0m"
cd temp/libgeneral
./autogen.sh
make
sudo make install
cd ../..

echo -e "\033[32mCloning img4tool...\033[0m"
git clone https://github.com/tihmstar/img4tool.git temp/img4tool

echo -e "\033[32mBuilding img4tool...\033[0m"
cd temp/img4tool
./autogen.sh
make
mv img4tool ~/.tools
cd ../..

echo -e "\033[32mCloning ipwnder_lite...\033[0m"
git clone https://github.com/dora2ios/ipwnder_lite.git temp/ipwnder_lite

echo -e "\033[32mBuilding ipwnder_lite...\033[0m"
cd temp/ipwnder_lite
make
mv ipwnder_macosx ~/.tools
cd ../..

echo -e "\033[32mInstalling libirecovery...\033[0m"
brew install libirecovery

echo -e "\033[32mCloning kairos...\033[0m"
git clone https://github.com/dayt0n/kairos.git temp/kairos

echo -e "\033[32mBuilding kairos...\033[0m"
cd temp/kairos
make
mv kairos ~/.tools
cd ../..

echo -e "\033[32mCloning libpartialzip...\033[0m"
git clone https://github.com/tihmstar/libpartialzip.git temp/libpartialzip

echo -e "\033[32mBuilding libpartialzip...\033[0m"
cd temp/libpartialzip
./autogen.sh
make
sudo make install
cd ../..

echo -e "\033[32mCloning partialZipBrowser...\033[0m"
git clone https://github.com/tihmstar/partialZipBrowser.git temp/partialZipBrowser

echo -e "\033[32mBuilding partialZipBrowser...\033[0m"
cd temp/partialZipBrowser
./autogen.sh
make
sudo make install
cd ../..

echo -e "\033[32mCloning sepless...\033[0m"
git clone https://github.com/Kaiden-AC/sepless.git temp/sepless

echo -e "\033[32mBuilding sepless...\033[0m"
cd temp/sepless
gcc src/sepless.c -o sepless
mv sepless ~/.tools
cd ../..

echo -e "\033[32mCloning seprmvr64...\033[0m"
git clone --recursive https://github.com/mineek/seprmvr64.git temp/seprmvr64

echo -e "\033[32mBuilding seprmvr64...\033[0m"
cd temp/seprmvr64
make
mv seprmvr64 ~/.tools
cd ../..

echo -e "\033[32mFetching seprmvr64lite...\033[0m"
curl -O https://github.com/Agricu/ios7.iarchive.app/raw/refs/heads/master/source/patchfinder64.c
curl -O https://github.com/Agricu/ios7.iarchive.app/raw/refs/heads/master/source/seprmvr64lite.c

echo -e "\033[32mBuilding seprmvr64lite...\033[0m"
cd temp/seprmvr64lite
gcc seprmvr64lite.c -o seprmvr64lite
mv seprmvr64lite ~/.tools
cd ../..

echo -e "\033[32mCloning tsschecker...\033[0m"
git clone --recursive https://github.com/tihmstar/tsschecker.git temp/tsschecker

echo -e "\033[32mBuilding tsschecker...\033[0m"
cd temp/tsschecker
./autogen.sh
make
sudo make install
cd ../..

echo -e "\033[32mAdding ~/.tools to system path...\033[0m"
sudo echo "/Users/$(whoami)/.tools" >> /etc/paths.d/tools

echo -e "\033[32mFinished!\033[0m"
