#!/bin/bash

cp genesis.json ~/.hyperspaced/config/ && hyperspaced gentx validator2 800000000stake --chain-id testnet-1
