
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