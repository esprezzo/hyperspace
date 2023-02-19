# Hyperspace
### Blockchain node software.

#### Focused on:
- Cosmwasm based game services
- On-chain consensus
- Safe cross-chain composability w/IBC

This software is used to run testnets (and mainnet when ready):

## Testnet v1: "The Barrens"
This is the first iteration of our testnet. Use at your own risk. All balances will be thrown away on migration to Testnet v2.

Stay up to date with the latest news on our Socials
 - Join our [Telegram Community](https://t.me/)
 - Join our [Discord](https://discord.gg/)
 - Follow us on [Twitter](https://twitter.com/)
 - Check out our [Medium](https://medium.com/)

## Dependencies
- A mildly powerful Unix-like system 4CPU/16G (Linux, MacOS, maybe Windows/WSL?)
- A working Go 1.19+ installation
- Basic Unix/Linux sysadmin skills
- An internet connection

# Node Installation from source.

### If you want to use a binary release see here: [releases](https://github.io/esprezzo/hyperspace/releases).


### If you want to install from source and already have a working Go 1.19+ installation:

```bash
# run these commands
git clone https://github.com/esprezzo/hyperspace.git
cd hyperspace
git fetch --tags
git checkout v0.1.0
make install
```

## If you need more direction configuring a system to compile and run a Golang 1.19
### Using Ubuntu or Debian Linux

- #### Install Prerequisites

```bash
# update the local package list and install any available upgrades 
sudo apt-get update && sudo apt upgrade -y 

# install toolchain and ensure accurate time synchronization 
sudo apt-get install make build-essential gcc git jq chrony -y
```

- #### Install Go

```bash
# download the latest version
wget https://go.dev/dl/go1.19.2.linux-amd64.tar.gz

# remove old version (if any)
sudo rm -rf /usr/local/go

# install the new version
sudo tar -C /usr/local -xzf go1.19.2.linux-amd64.tar.gz
```

- #### Configure Environment Variables
```bash
# run these commands
cat <<EOF >> ~/.profile
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GO111MODULE=on
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
EOF

source ~/.profile

go version
```
The output should be `go version go1.19 linux/amd64`

- #### Install blockchain node from sources

```bash
# run these commands
git clone https://github.com/hyperspace/hyperspace.git
cd hyperspace
git fetch --tags
git checkout v0.1.0
make install
```

To verify the installation you can run `hyperspaced version` and it should return `v0.1.0`

- #### Initialize the Chain
Replace `$MONIKERNAME` with your choosen node name

`hyperspaced init $MONIKER_NAME --chain-id hypertest-1`

- #### Download the Genesis

```bash
wget -O ~/.hyperspaced/config/genesis.json https://raw.githubusercontent.com/esprezzo/hyperspace/main/mainnet/genesis.json
```

- #### Add Seeds & Persistent Peers
TODO

- #### Update minimum-gas-price in app.toml

```bash
sed -i.bak 's/minimum-gas-prices =.*/minimum-gas-prices = "1uxpz"/' $HOME/.hyperspaced/config/app.toml
```

- #### Setting up Cosmovisor

Install cosmovisor 
```bash
go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor@v1.0.0

which cosmovisor

# should return 
'/home/<your-user>/go/bin/cosmovisor'

# run these commands
cat <<EOF >> ~/.profile
export DAEMON_NAME=hyperspaced
export DAEMON_HOME=$HOME/.hyperspaced
EOF

source ~/.profile

echo $DAEMON_NAME

# should return
'hyperspaced'

# create the directories
mkdir -p $DAEMON_HOME/cosmovisor/genesis/bin
mkdir -p $DAEMON_HOME/cosmovisor/upgrades

# check the binary path with
which hyperspaced

# this should return
'/home/your-user/go/bin/hyperspaced'

# copy the binary into
cp $(which hyperspaced) $DAEMON_HOME/cosmovisor/genesis/bin
```
Set up the service file

```bash
sudo nano /etc/systemd/system/hyperspaced.service

# paste and edit <your-user> with your username
[Unit]
Description=Versus Daemon (cosmovisor)
After=network-online.target

[Service]
User=<your-user>
ExecStart=/home/<your-user>/go/bin/cosmovisor start
Restart=always
RestartSec=3
LimitNOFILE=4096
Environment="DAEMON_NAME=hyperspaced"
Environment="DAEMON_HOME=/home/<your-user>/.hyperspaced"
Environment="DAEMON_ALLOW_DOWNLOAD_BINARIES=false"
Environment="DAEMON_RESTART_AFTER_UPGRADE=true"
Environment="DAEMON_LOG_BUFFER_SIZE=512"

[Install]
WantedBy=multi-user.target
```

Enable the service

```bash
sudo -S systemctl daemon-reload
sudo -S systemctl enable hyperspaced
```

- #### Start the node

You can start the node by running
```bash
sudo systemctl start hyperspaced

# check the logs by running
journalctl -u hyperspaced -f
```
The node will take some time to catch-up with the blockchain.
You can follow the blocks being indexed by running

```bash
journalctl -u hyperspaced -f | grep indexed
```

```bash
# create a new wallet for the validator
hyperspaced keys add <key-name>

# save the seed phrase (mnemonic) in a safe place
# copy the 'hyperspace...' address and send some HUAHUA
# in order to pay for the validator creation's transaction

# Make sure the Validator has fully synced before running 
hyperspaced tx staking create-validator \
  --from "<key-name>" \
  --amount "1000000uxpz" \
  --pubkey "$(hyperspaced tendermint show-validator)" \
  --chain-id "hyperspace-1" \
  --moniker "<moniker>" \
  --commission-max-change-rate 0.01 \
  --commission-max-rate 0.20 \
  --commission-rate 0.10 \
  --min-self-delegation 1 \
  --details "<details>" \
  --security-contact "<contact>" \
  --website "<website>" \
  --gas-prices "1uxpz"
  
# Make sure to backup the priv_validator_key.json file in your
# /home/<your-user>/.hyperspaced/config directory
# and store it in a safe place
```

**Congratulation!** Your Validator node should be up and running

_Make sure to join our [Discord](https://discord.gg/hyperspace) and contact a moderator if you have a mainnet node so we can invite you to the validator's channel to follow up the latest updates and future upgrades._

---

# Chain Upgrades
