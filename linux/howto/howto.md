# Ubuntu setup (WIP)

Ideas for Ubuntu setup and install commands

## Tthings to do after installing Ubuntu 22.04
https://www.omgubuntu.co.uk/2022/04/installed-ubuntu-22-04-do-these-things-next


## Install additional libs ?

```bash
sudo apt install libbz2-dev libffi-dev liblzma-dev libreadline-dev libsqlite3-dev libssl-dev tk-dev zlib1g-dev -y
```


## Install Firefox (no snap)

Step 1: Remove the Firefox Snap by running the following command in a new Terminal window:
```bash
sudo snap remove firefox
```

Step 2: Add the (Ubuntu) Mozilla team PPA to your list of software sources by running the following command in the same Terminal window:
```bash
sudo add-apt-repository ppa:mozillateam/ppa
```

Step 3: Next, alter the Firefox package priority to ensure the PPA/deb/apt version of Firefox is preferred. This can be done using a slither of code from [FosTips](https://fostips.com/ubuntu-21-10-two-firefox-remove-snap/) (copy and paste it whole, not line by line):
```bash
echo '
Package: firefox*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001

Package: firefox*
Pin: release o=Ubuntu*
Pin-Priority: -1
' | sudo tee /etc/apt/preferences.d/mozilla-firefox
```

Step 4: Since you’ll (hopefully) want future Firefox upgrades to be installed automatically, Balint Reczey shares a concise command on his blog that ensures it happens:
```bash
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox
```

Step 5: Finally, install Firefox via apt by running this command:
```bash
sudo apt install firefox -y
```

## Git
```bash
sudo apt install git -y
```

- setup git keys ??

```bash
ssh-keygen -t ed25519 -C "stanislav.sabev@gmail.com"
# you will be asked to create file and passfrase
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
ssh -T git@github.com
code ~/.ssh/id_ed25519.pub
```

# VSCode

- import GPG Key
```bash
sudo apt install software-properties-common apt-transport-https wget gpg -y
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
```
- add Microsoft's VSCode repository
```bash
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
```
- run system update
```bash
sudo apt update
```

- install VSCode
```bash
sudo apt install code
```

# Dotfiles

- dotfiles dir - `~/.dotfiles`

```bash

git clone git@github.com:stanislavsabev/dotfiles.git
git clone https://github.com/stanislavsabev/dotfiles.git

```

## Pyenv

- setup pyenv

```bash
# setup
sudo apt update && sudo apt upgrade -y
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl libdvd-pkg
sudo dpkg-reconfigure libdvd-pkg
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
cd .pyenv/
src/configure && make -C src
```
- install Python

```bash
# install Python
pyenv install --list | grep " 3\."
pyenv install 3.7 3.8 3.9 3.10 3.11
pyenv versions
pyenv global 3.11
pyenv which python
```

## Fix scrolling

```bash
xinput list-props 13 | grep -i scrolling
xinput -set-prop 13 "libinput Scrolling Pixel Distance" 35
```


## tmux

```bash
sudo apt install tmux -y
```

## Dotnet tools install commands


## Vulkan

```bash
sudo apt update
sudo apt upgrade -y
sudo apt install build-essential -y 
sudo apt install vulkan-tools -y 
```

- test with vkcube

```bash
echo "test with 'vkcube"
```

- vulkan dev tools

```bash
sudo apt install libvulkan-dev 
sudo apt install vulkan-validationlayers
sudo apt install spirv-tools 
sudo apt install vulkan-validationlayers spirv-tools
# not sure about next line
api
```

## GLFW
```bash
sudo apt install libglfw3-dev libglm-dev -y
```

## Popular theme for qbittorrent 

``` bash
cd ~/opt
git clone https://github.com/jagannatharjun/qbt-theme.git
```

## Install qbittorrent
```bash
sudo apt install qbittorrent -y
```

## Install vlc

```bash
sudo apt update && sudo apt install vlc -y
sudo apt install vlc-plugin-access-extra libbluray-bdj libdvd-pkg -y 
sudo apt install vlc-plugin-bittorrent -y
```

## Drakula theme for gnome-terminal and qbittorrent

```bash
cd ~/opt
mkdir dracula
cd dracula/
git clone https://github.com/dracula/qbittorrent.git
git clone https://github.com/dracula/gnome-terminal
chmod -R 777 qbittorrent
mod qbittorrent qbittorrent
cd qbittorrent/webui
make
cd ~/opt/dracula/qbittorrent/
code dracula.qbtheme 

```

## Nvidia drivers

```bash
sudo hwinfo --gfxcard --short
sudo ls hw -C display
sudo lshw -C display
sudo apt install nvidia-driver-510 nvidia-dkms-510
sudo apt update
sudo reboot
```

## VirtualBox

- install

```bash
sudo add-apt-repository multiverse && sudo apt-get update
sudo apt install virtualbox -y
```

- Extension pack
```bash
sudo apt install virtualbox-ext-pack -y
```

- remove

- Uninstall extension package ?
```bash
sudo apt ins virtualbox-ext-pack -y
```

```bash
sudo apt remove virtualbox
sudo apt purge virtualbox
```

## Bitwarden
```bash
sudo apt update -y && sudo apt upgrade -y
apt install apt-transport-https ca-certificates curl software-properties-common -y

