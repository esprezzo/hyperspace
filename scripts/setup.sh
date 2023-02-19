#!/bin/bash
git clone https://github.com/hyperspace/hyperspace.git
cd hyperspace
git fetch --tags
git checkout v0.1.0
make install