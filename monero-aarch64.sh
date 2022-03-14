#!/bin/bash

####################################
# Mine Monero on your Raspberry Pi #
#      script by @ryanfortner      #
####################################

# credits: Botspot/pi-apps pull#1379, kryptokrona docs

echo "monero-aarch64.sh"

# get user input
echo "You need a Monero wallet for mining to work."
echo "See the README of my repo for more info."
read -rp "REQUIRED: enter a wallet address. (Example: 48WU5jtuCJ9Hh1SvviEYsaB4nupw819Ke8tzBe8NMbvMCSHUCBcxWgTfvndqDHVfbEFxbKMSqKPd1dSXCcT9VHVC7XwFfyD) " WALLET
read -rp "REQUIRED: enter a worker name. (Example: RaspberryPi) " WORKERNAME

function setup {
    echo "installing dependencies..."
    sudo apt-get update
    sudo apt-get install git build-essential cmake make libuv1-dev libmicrohttpd-dev gcc g++ automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev -y
    git clone https://github.com/MoneroOcean/xmrig.git monero-xmrig
}

### script start ###
setup

cd ~/monero-xmrig

mkdir build
cd build

if [ "$(1)" == "--rpi2" ]; then
    echo "running cmake for rpi2..."
    cmake .. -DCMAKE_C_FLAGS="-mcpu=cortex-a7 -mtune=cortex-a7" -DCMAKE_CXX_FLAGS="-mcpu=cortex-a7 -mtune=cortex-a7" || cmake .. -DARM_TARGET=7
elif [ "$(2)" == "--rpi3" ]; then
    echo "running cmake for rpi3..."
    cmake .. -DCMAKE_C_FLAGS="-mcpu=cortex-a53 -mtune=cortex-a53" -DCMAKE_CXX_FLAGS="-mcpu=cortex-a53 -mtune=cortex-a53"
elif [ "$(2)" == "--rpi4" ]; then
    echo "running cmake for rpi4..."
    cmake .. -DCMAKE_C_FLAGS="-mcpu=cortex-a72 -mtune=cortex-a72" -DCMAKE_CXX_FLAGS="-mcpu=cortex-a72 -mtune=cortex-a72"
elif [ "$(2)" == "--tinkerboard" ]; then
    echo "running cmake for tinkerboard..."
    cmake .. -DCMAKE_C_FLAGS="-march=armv7-a" -DCMAKE_CXX_FLAGS="-march=armv7-a"
else
    echo "running cmake..."
    cmake ..
fi

echo "running make..."
make -j$(nproc)

echo "downloading icon..."
wget https://raw.githubusercontent.com/ryanfortner/ryanfortner/main/7450663.png -O monero-icon.png

echo "creating run script..."
echo "#!/bin/bash
function ctrl_c() {
  break &>/dev/null
  echo "ctrl_c detected! close this window to exit."
  sleep infinity
}
trap "ctrl_c" 2
cd $HOME/monero-xmrig/build
./xmrig -o gulf.moneroocean.stream:10032 -u $WALLET -p ${WORKERNAME}~rx/arq
sleep infinity" > run-miner.sh
chmod +x run-miner.sh

echo "creating desktop entry..."
echo "[Desktop Entry]
Name=Monero Miner
GenericName=Mine XMR
Comment=Mine Monero (XMR)
Exec=bash $HOME/monero-xmrig/build/run-miner.sh
Icon=$HOME/monero-xmrig/build/monero-icon.png
Terminal=true
StartupNotify=true
Type=Application
Categories=Utility;" > ~/.local/share/applications/monero-miner.desktop

echo "done!"