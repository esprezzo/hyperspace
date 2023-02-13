#!/bin/bash

# hyperspaced keys add validator-one

# hyperspaced tx staking create-validator \
#   --from "validator-one" \
#   --amount "1000000uxpz" \
#   --pubkey "$(hyperspaced tendermint show-validator)" \
#   --chain-id "hypertest-1" \
#   --moniker "hypertest val 1" \
#   --commission-max-change-rate 0.01 \
#   --commission-max-rate 0.20 \
#   --commission-rate 0.10 \
#   --min-self-delegation 1 \
#   --details "this is a test val for hyperspace testnet" \
#   --security-contact "contact" \
#   --website "esprezzo.io" \
#   --gas-prices "1uxpz"