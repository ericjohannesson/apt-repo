# apt-repo

My APT repository, containing various pre-compiled debian-packages.

## How to add this repository

To add this repository on a debian based linux distributions, run the following commands in the terminal:

1. import my public pgp-key:
```bash
curl https://ericjohannesson.github.io/apt-repo/apt/ericjohannesson-keyring.asc | sudo tee /usr/share/keyrings/ericjohannesson-keyring.asc
```

2. add this repo to your list of apt-repositories:
```bash
echo "deb [signed-by=/usr/share/keyrings/ericjohannesson-keyring.asc arch=amd64] https://ericjohannesson.github.io/apt-repo/apt/repo noble main" \
| sudo tee /etc/apt/sources.list.d/ericjohannesson.list
```
