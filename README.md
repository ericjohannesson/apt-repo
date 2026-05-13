# apt-repo

My apt-repository, containing various pre-compiled debian-packages, built with [reprepro](https://github.com/ionos-cloud/reprepro).

## How to add this repository

To add this repository on a debian-based linux distribution using apt, run the following commands in the terminal:

1. Import my public pgp-key:
```bash
curl https://ericjohannesson.github.io/apt-repo/apt/ericjohannesson-keyring.asc \
| sudo tee /usr/share/keyrings/ericjohannesson-keyring.asc
```

2. Add this repository to your list of apt-repositories:
```bash
echo "deb [signed-by=/usr/share/keyrings/ericjohannesson-keyring.asc arch=amd64] https://ericjohannesson.github.io/apt-repo/apt/repo noble main" \
| sudo tee /etc/apt/sources.list.d/ericjohannesson.list
```
