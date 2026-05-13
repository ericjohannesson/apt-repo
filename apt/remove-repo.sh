#!/usr/bin/bash

# remove my public pgp-key:
sudo rm /usr/share/keyrings/ericjohannesson-keyring.asc

# rempove this repo from your list of apt-repos:
sudo rm /etc/apt/sources.list.d/ericjohannesson.list
