#! /bin/bash

apt install git cmake build-essential libgtk2.0-dev libasound2-dev python3-minimal libavformat-dev libjack-jackd2-dev

# wxWidgets 3.1:
git clone --recurse-submodules https://github.com/audacity/wxWidgets/

# Build and install wxWidgets:
cd ./wxWidgets
mkdir buildgtk && cd buildgtk
../configure --with-cxx=14 --with-gtk=2

make -j4 install # Build process made quicker using the "-j" switch:

cd ../..

# Audacity (latest):
git clone --recurse-submodules https://github.com/audacity/audacity/

#1. Build audacity:
cd ./audacity
mkdir build && cd build

#2. Generate makefiles:
cmake -DCMAKE_BUILD_TYPE=Release -Daudacity_use_ffmpeg=loaded ..

#3. Build Audacity (using 4 of 8 cores):
make -j4

#4. Testing build:
cd bin/Release && mkdir "Portable Settings"
./audacity

#Install:
cd ../../build
make install

#Options:
#The above example will produce full release build, with FFmpeg enabled.
#A full list of options may be listed in the terminal by running:
#cmake -LH
