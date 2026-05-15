#!/usr/bin/bash

# import my public pgp-key:
wget https://ericjohannesson.github.io/apt-repo/apt/ericjohannesson-keyring.asc \
&& sudo mv ericjohannesson-keyring.asc /usr/share/keyrings/

# add this repo to your list of apt-repos:
echo "deb [signed-by=/usr/share/keyrings/ericjohannesson-keyring.asc arch=amd64] https://ericjohannesson.github.io/apt-repo/apt/repo ericjohannesson main" \
| sudo tee /etc/apt/sources.list.d/ericjohannesson.list
