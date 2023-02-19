#!/bin/bash
git clone https://github.com/hyperspace/hyperspace.git
cd hyperspace
git fetch --tags
git checkout v0.1.0
make install

hyperspaced init $MONIKER_NAME --chain-id hypertest-1

wget -O ~/.hyperspaced/config/genesis.json https://raw.githubusercontent.com/esprezzo/hyperspace/main/testnet-1/genesis.json

sed -i.bak 's/minimum-gas-prices =.*/minimum-gas-prices = "1uxpz"/' $HOME/.hyperspaced/config/app.toml
