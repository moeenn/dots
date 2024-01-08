#! /bin/bash

sudo apt-get install build-essential libasound2-dev libx11-dev libxrandr-dev libxi-dev libgl1-mesa-dev libglu1-mesa-dev libxcursor-dev libxinerama-dev

cd ~/Downloads/
git clone https://github.com/raysan5/raylib.git --depth=1 raylib
cd raylib/src/
make PLATFORM=PLATFORM_DESKTOP

sudo make install
