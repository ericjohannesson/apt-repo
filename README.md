# apt-repo

My apt-repository, containing various pre-compiled debian-packages.

To use this repository on a debian-based linux distribution with apt, run the following commands in the terminal:

1. Import my public pgp-key:
```bash
curl https://ericjohannesson.github.io/apt-repo/apt/ericjohannesson-keyring.asc \
| sudo tee /usr/share/keyrings/ericjohannesson-keyring.asc
```

2. Add this repository to your list of apt-repositories:
```bash
curl https://ericjohannesson.github.io/apt-repo/apt/ericjohannesson.sources \
| sudo tee /etc/apt/sources.list.d/ericjohannesson.sources
```

3. Update:
```bash
sudo apt update
```
