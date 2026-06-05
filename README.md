# apt-repo

My apt-repository, containing various pre-compiled debian-packages.

To use this repository on a debian-based linux distribution with apt, run the following commands in the terminal:

1. Import my public pgp-key:
```bash
wget https://ericjohannesson.github.io/apt-repo/apt/ericjohannesson-keyring.asc \
&& sudo mv ericjohannesson-keyring.asc /usr/share/keyrings/
```

2. Add this repository to your list of apt-repositories:
```bash
wget https://ericjohannesson.github.io/apt-repo/apt/ericjohannesson.list \
&& sudo mv ericjohannesson.list /etc/apt/sources.list.d/
```

3. Update:
```bash
sudo apt update
```
