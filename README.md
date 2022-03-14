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
#### 64-bit
48-hour profit: $0.01 USD

Hashrate: --
- You will need a Monero wallet address.
- The script uses [MoneroOcean](https://moneroocean.stream), an easy-to-use mining pool with no signup required.
- This script has many optimizations to be able to work well on a Raspberry Pi, including using the `rx/arq` algorithm.
```bash
wget https://raw.githubusercontent.com/ryanfortner/rpi-cryptomining-scripts/master/monero-aarch64.sh
chmod +x monero-aarch64.sh
# raspberry pi 2
./monero-aarch64.sh --rpi2
# raspberry pi 3
./monero-aarch64.sh --rpi3
# raspberry pi 4
./monero-aarch64.sh --rpi4
# tinkerboard 
./monero-aarch64.sh --tinkerboard
# others
./monero-aarch64.sh
rm monero-aarch64.sh
```
