#!/bin/bash
git clone https://github.com/hyperspace/hyperspace.git
cd hyperspace
git fetch --tags
git checkout develop
make install

hyperspaced init $MONIKER_NAME --chain-id testnet-1

wget -O ~/.hyperspaced/config/genesis.json https://raw.githubusercontent.com/esprezzo/hyperspace/main/testnet-1/genesis.json

sed -i.bak 's/minimum-gas-prices =.*/minimum-gas-prices = "1uxpz"/' $HOME/.hyperspaced/config/app.toml

seeds="77cbb35d1df17f48a42e9f157f12f55b691e9f5e@seeds.goldenratiostaking.net:1620,4936e377b4d4f17048f8961838a5035a4d21240c@chihuahua-seed-01.mercury-nodes.net:29540"
peers="b140eb36b20f3d201936c4757d5a1dcbf03a42f1@216.238.79.138:26656,19900e1d2b10be9c6672dae7abd1827c8e1aad1e@161.97.96.253:26656,c382a9a0d4c0606d785d2c7c2673a0825f7c53b2@88.99.94.120:26656,a5dfb048e4ed5c3b7d246aea317ab302426b37a1@137.184.250.180:26656,3bad0326026ca4e29c64c8d206c90a968f38edbe@128.199.165.78:26656,89b576c3eb72a4f0c66dc0899bec7c21552ea2a5@23.88.7.73:29538,38547b7b6868f93af1664d9ab0e718949b8853ec@54.184.20.240:30758,a9640eb569620d1f7be018a9e1919b0357a18b8c@38.146.3.160:26656,7e2239a0d4a0176fe4daf7a3fecd15ac663a8eb6@144.91.126.23:26656"
sed -i.bak -e "s/^seeds *=.*/seeds = \"$seeds\"/; s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" ~/.chihuahuad/config/config.toml
