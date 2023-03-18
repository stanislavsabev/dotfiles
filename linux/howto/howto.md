# Ubuntu setup (WIP)

Ideas for Ubuntu setup and install commands

## Install additional libs ?

```bash
sudo apt install libbz2-dev libffi-dev liblzma-dev libreadline-dev libsqlite3-dev libssl-dev tk-dev zlib1g-dev
```

## Git

- setup git keys ??

```bash
ssh-keygen -t ed25519 -C "stanislav.sabev@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub 
code ~/.ssh/id_ed25519.pub 
ssh -T git@github.com
code ~/.ssh/id_ed25519.pub
```

# Dotfiles

- dotfiles dir - `~/opt/dotfiles/`

```bash
cd ~/opt

git clone git@github.com:stanislavsabev/devsetup.git
git checkout ubuntu
```


# Symbolic links

```bash
ln -s opt/dotfiles/bashrc .bashrc
ln -s opt/dotfiles/tmux.conf .tmux.conf
ln -s opt/dotfiles/gitignore_global .gitignore_global
ln -s opt/dotfiles/gitconfig .gitconfig
```

## Pyenv

- setup pyenv

```bash
# setup
sudo apt update && sudo apt upgrade -y
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl python3-openssl
sudo dpkg-reconfigure libdvd-pkg
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
cd .pyenv/
src/configure && make -C src
```
- install Python

```bash
# install Python
pyenv install --list | grep " 3\."
pyenv install 3.7 3.8 3.9 3.11
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
sudo apt install tmux
```

## Dotnet tools install commands


## Vulkan

```bash
sudo apt update
sudo apt upgrade -y
sudo apt install build-essential 
sudo apt install vulkan-tools 
# test with vkcube
echo "test with 'vkcube"
```

```bash
# vulkan dev tools
sudo apt install libvulkan-dev 
sudo apt install vulkan-validationlayers
sudo apt install spirv-tools 
sudo apt install vulkan-validationlayers spirv-tools
# not sure about next line
api
```

## GLFW
```bash
sudo apt install libglfw3-d
sudo apt install libglfw3-de 
sudo apt install libglfw3-dev 
sudo apt install libglm-dev 
```

## Popular theme for qbittorrent 

``` bash
cd ~/opt
git clone https://github.com/jagannatharjun/qbt-theme.git
```

## Install vlc

```bash
sudo apt update && sudo apt install vlc
sudo apt install vlc-plugin-access-extra libbluray-bdj libdvd-pkg
sudo apt install vlc-plugin-bittorrent -y
```

## Install qbittorrent
```bash
sudo apt install qbittorrent
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
cd qbittorrent/
cd webui
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
sudo apt install virtualbox
```


```bash
# Extension pack
sudo apt install virtualbox-ext-pack
```

- remove

```bash
# Uninstall extension package
sudo apt ins virtualbox-ext-pack
```

```bash
sudo apt remove virtualbox
sudo apt purge virtualbox
```
