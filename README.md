# rpi-cryptomining-scripts
Mine different crypto currenccies on your Raspberry Pi!

Many more crypto currencies coming soon!

### XMG (Coin Magi)
#### 64-bit
48-hour profit: $0.05 USD
Hashrate: --
- You will need to have a mining pool as well as a pool username and password. The script will ask you for those three values upon running.
- I suggest using [xmg.minerclaim.net](https://xmg.minerclaim.net/), since it's super easy to set up.
- The script will automatically create a desktop entry. You can launch using that, through the Main Menu -> Accessories -> Magi Miner. Or, launch from the terminal using the command: ~/wolf-m7m-cpuminer/run-miner.sh
```bash
wget https://raw.githubusercontent.com/ryanfortner/rpi-cryptomining-scripts/master/magi-aarch64.sh; bash magi-aarch64.sh; rm magi-aarch64.sh
```

### XMR (Monero)
#### 32/64-bit
48-hour profit: $0.01 USD
Hashrate: --
- You will need a mining pool as well as a username and password for that pool.
- In this case we'll be using MoneroOcean which requires no signup and you can just use a wallet address.
- This script has many optimizations to be able to work well on a Raspberry Pi.
```bash
sudo apt-get update
sudo apt-get install git build-essential cmake make libuv1-dev libmicrohttpd-dev gcc g++ automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev -y
git clone https://github.com/MoneroOcean/xmrig.git monero-xmrig
cd monero-xmrig
mkdir build && cd build
# for any computer
cmake ..
# for raspberry pi 2
cmake .. -DCMAKE_C_FLAGS="-mcpu=cortex-a7 -mtune=cortex-a7" -DCMAKE_CXX_FLAGS="-mcpu=cortex-a7 -mtune=cortex-a7"
# for raspberry pi 2 if the above doesn't work
cmake .. -DARM_TARGET=7
# for raspberry pi 3
cmake .. -DCMAKE_C_FLAGS="-mcpu=cortex-a53 -mtune=cortex-a53" -DCMAKE_CXX_FLAGS="-mcpu=cortex-a53 -mtune=cortex-a53"
# for raspberry pi 4
cmake .. -DCMAKE_C_FLAGS="-mcpu=cortex-a72 -mtune=cortex-a72" -DCMAKE_CXX_FLAGS="-mcpu=cortex-a72 -mtune=cortex-a72"
# for asus tinker board 
cmake .. -DCMAKE_C_FLAGS="-march=armv7-a" -DCMAKE_CXX_FLAGS="-march=armv7-a"

make -j$(nproc)

# run the miner (replace yourwallethere and workername with the necessary values)
./xmrig -o gulf.moneroocean.stream:10032 -u YOURWALLETHERE -p WORKERNAME~rx/arq
```