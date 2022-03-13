#!/bin/bash

#######################################
# Mine Magi-Coin on your Raspberry Pi #
#       script by @ryanfortner        #
#######################################

# credits: novaspirit tech on YouTube, kryptokrona docs

echo "magi-aarch64.sh"

# get user input
echo "You need a mining pool for mining to work."
echo "See the README of my repo for more info."
read -rp "REQUIRED: enter a miner pool URL. (Example: stratum+tcp://xmg.minerclaim.net:7008) " MINERPOOL_URL
read -rp "REQUIRED: enter a miner pool username. (Example: ryanfortner.Worker1) " WORKER_USERNAME
read -rp "REQUIRED: enter a miner pool password. " WORKER_PASSWORD

function setup {
    echo "installing dependencies..."
    sudo apt-get update
    sudo apt-get install automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev make g++ git libgmp-dev -y
    cd ~/
    rm -rf ./wolf-m7m-cpuminer/
    echo "cloning miner..."
    git clone https://github.com/ryanfortner/wolf-m7m-cpuminer
}

### script start ###
setup

cd ~/wolf-m7m-cpuminer

echo "running autogen.sh..."
./autogen.sh

echo "running configure..."
CFLAG="-O2 mfpu=neon-vfpv4" ./configure --with-curl --with-crypto

echo "running make..."
make -j$(nproc)

echo "downloading icon..."
wget https://raw.githubusercontent.com/m-pays/m-core.org/master/assets/img/magiblue.svg

echo "creating run script..."
echo "#!/bin/bash
function ctrl_c() {
  break &>/dev/null
  echo "ctrl_c detected! close this window to exit."
  sleep infinity
}
trap "ctrl_c" 2
cd $HOME/wolf-m7m-cpuminer
./minerd -a m7mhash -o $MINERPOOL_URL -u $WORKER_USERNAME -p $WORKER_PASSWORD
sleep infinity" > run-miner.sh
chmod +x run-miner.sh

echo "creating desktop entry..."
echo "[Desktop Entry]
Name=Magi Miner
GenericName=Mine XMG
Comment=Mine Coin Magi (XMG)
Exec=bash $HOME/wolf-m7m-cpuminer/run-miner.sh
Icon=$HOME/wolf-m7m-cpuminer/magiblue.svg
Terminal=true
StartupNotify=true
Type=Application
Categories=Utility;" > ~/.local/share/applications/magi-miner.desktop

echo "done!"