SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -O globstar -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

repo_origin = Eric Johannesson
repo_codename = noble
repo_label = ericjohannesson
repo_architectures = amd64
repo_description = My APT repository
repo_suite = stable
repo_component = main

repo_container = apt
repo_path = ${repo_container}/repo
deb_sources = ~/Files/no-markup-markup/nmm-ocaml/debian/packages/ ~/Files/scripts/cmd-sync/debian/packages/
key_id = eric@ericjohannesson.com
key_name = ${repo_label}-keyring.asc

base_url = https://ericjohannesson.github.io/apt-repo
key_url = ${base_url}/${repo_container}/${key_name}
repo_url = ${base_url}/${repo_path}

repo_section = misc
add_repo_script_name = add-repo.sh
remove_repo_script_name = remove-repo.sh

define add_repo_script
#!/usr/bin/bash

# import my public pgp-key:
curl ${key_url} | sudo tee /usr/share/keyrings/${key_name}

# add this repo to your list of apt-repos:
echo \"deb [signed-by=/usr/share/keyrings/${key_name} arch=amd64] ${repo_url} ${repo_codename} ${repo_component}\" \\
| sudo tee /etc/apt/sources.list.d/${repo_label}.list
endef

define remove_repo_script
#!/usr/bin/bash

# remove my public pgp-key:
sudo rm /usr/share/keyrings/${key_name}

# rempove this repo from your list of apt-repos:
sudo rm /etc/apt/sources.list.d/${repo_label}.list
endef


define distributions
Origin: ${repo_origin}
Label: ${repo_label}
Suite: ${repo_suite}
Codename: ${repo_codename}
Architectures: ${repo_architectures}
Components: ${repo_component}
Description: ${repo_description}
endef


${repo_path}/conf/distributions:
	mkdir -p ${repo_path}/conf
	echo "${distributions}" > ${repo_path}/conf/distributions

${repo_path}/incoming:
	mkdir -p ${repo_path}/incoming
	rsync -av ${deb_sources} ${repo_path}/incoming/


${repo_path}/dists/${repo_codename}/Release: ${repo_path}/conf/distributions ${repo_path}/incoming
	cd ${repo_path}
	reprepro -v --section ${repo_section} --component ${repo_component} --priority 0 includedeb ${repo_codename} incoming/*.deb
	cd -

${repo_path}/dists/${repo_codename}/Release.asc: ${repo_path}/dists/${repo_codename}/Release
	cd ${repo_path}
	gpg --default-key "${key_id}" --detach-sign --armor -o "dists/${repo_codename}/Release.asc" "dists/${repo_codename}/Release"
	cd -

${repo_path}/dists/${repo_codename}/InRelease: ${repo_path}/dists/${repo_codename}/Release
	cd ${repo_path}
	gpg --default-key "${key_id}" --sign --armor --clearsign -o "dists/${repo_codename}/InRelease" "dists/${repo_codename}/Release"
	cd -

${repo_path}/dists/${repo_codename}: ${repo_path}/dists/${repo_codename}/Release.asc ${repo_path}/dists/${repo_codename}/InRelease

${repo_container}/${key_name}:
	gpg --export --armor "${key_id}" > "${repo_container}/${key_name}"

${repo_container}/${add_repo_script_name}:
	echo "${add_repo_script}" > "${repo_container}/${add_repo_script_name}"

${repo_container}/${remove_repo_script_name}:
	echo "${remove_repo_script}" > "${repo_container}/${remove_repo_script_name}"

${repo_container}: ${repo_path}/dists/${repo_codename} ${repo_container}/${key_name} ${repo_container}/${add_repo_script_name} ${repo_container}/${remove_repo_script_name}


clean:
	rm -rf ${repo_container}

