#!/usr/bin/env bash


echo ">> Run install script for Ubuntu 22.04 LTS"

sudo apt-get update -y
sudo apt-get upgrade -y

echo ">> Install additional dev libs"

sudo apt-get install -y \
     libbz2-dev libdvd-pk libffi-dev liblzma-dev libncurses5-dev \
     libncursesw5-dev libreadline-dev libsqlite3-dev libssl-dev \
     zlib1g-dev xz-utils llvm python3-openssl \
     exa git curl wget make build-essential \
    tk-dev tmux vim
sudo apt-get update -y


echo "Install qbittorrent, vlc"
sudo apt-get update -y
sudo apt-get install -y qbittorrent 
sudo sudo apt-get install vlc -y
sudo apt install -y vlc-plugin-access-extra libbluray-bdj libdvd-pkg 
sudo apt install -y vlc-plugin-bittorrent


echo ">> Install Pyenv"

sudo apt-get install -y libdvd-pkg
sudo dpkg-reconfigure libdvd-pkg
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
cd .pyenv/
src/configure && make -C src
cd
pyenv install 3.7 3.8 3.9 3.10 3.11
pyenv global 3.11

echo ">> Install fish shell"
sudo apt-get update -y
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get update -y
sudo apt-get install fish

sudo apt-get update
curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install > install
command fish install

echo ">> Success. Installation script finished without errors!"
