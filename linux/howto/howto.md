# Ubuntu setup (WIP)

Ideas for Ubuntu setup and install commands

## Things to do after installing Ubuntu 22.04

https://www.omgubuntu.co.uk/2022/04/installed-ubuntu-22-04-do-these-things-next


```bash
sudo apt-get update -y
sudo apt-get upgrade -y
```

## Install additional libs + git, vim, tmux, exa

```bash
sudo apt install -y libbz2-dev libffi-dev liblzma-dev libreadline-dev libsqlite3-dev libssl-dev tk-dev zlib1g-dev
sudo apt install -y git vim tmux exa
```

## Setup git keys (not finished)

```bash
ssh-keygen -t ed25519 -C "stanislav.sabev@gmail.com"
# you will be asked to create file and passfrase
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
ssh -T git@github.com
code ~/.ssh/id_ed25519.pub
```

## Dotfiles

```bash
cd ~
# git clone git@github.com:stanislavsabev/dotfiles.git .dotfiles
git clone https://github.com/stanislavsabev/dotfiles.git .dotfiles
```

## install fish shell via ppa
  
```bash
sudo apt-add-repository -y ppa:fish-shell/release-3
sudo apt update
sudo apt install -y fish
```
  
### Install oh-my-fish
  
```bash
cd ~/.config
sudo apt-get update
curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install > install
fish install
rm -rf install
cd ~
```

## Flatpack

```bash
sudo apt install flatpak -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo apt-get install gnome-software-plugin-flatpak
sudo reboot now
```


### Install Slack

```bash
flatpak install flathub com.slack.Slack -y
```

### remove Slack

```bash
flatpak uninstall --delete-data flathub com.slack.Slack
flatpak remove --unused
```

### manage packages
https://ubuntuhandbook.org/index.php/2021/06/manage-flatpak-apps-ubuntu/

### also see
    flatpak install -y flathub org.gimp.GIMP
    flatpak install -y flathub com.spotify.Client
    flatpak install -y flathub com.discordapp.Discord


## Install Firefox (no snap)

#### Step 1: Remove the Firefox Snap by running the following command in a new Terminal window:

```bash
sudo snap remove firefox --purge
```

#### Step 2: Add the (Ubuntu) Mozilla team PPA to your list of software sources by running the following command in the same Terminal window:

```bash
sudo add-apt-repository ppa:mozillateam/ppa
```

#### Step 3: Next, alter the Firefox package priority to ensure the PPA/deb/apt version of Firefox is preferred. This can be done using a slither of code from [FosTips](https://fostips.com/ubuntu-21-10-two-firefox-remove-snap/) (copy and paste it whole, not line by line):

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

#### Step 4: Since you’ll (hopefully) want future Firefox upgrades to be installed automatically, Balint Reczey shares a concise command on his blog that ensures it happens:

```bash
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox
```

#### Step 5: Finally, install Firefox via apt by running this command:

```bash
sudo apt install firefox -y
```

## VSCode

#### import GPG Key

```bash
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo apt install software-properties-common apt-transport-https wget gpg -y
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
```

#### add Microsoft's VSCode repository

```bash
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
```

#### run system update

```bash
sudo apt update
```

#### install VSCode

```bash
sudo apt install code
```

### Add 'Open in Code' to the context menu
```bash
wget -qO- https://raw.githubusercontent.com/cra0zy/code-nautilus/master/install.sh | bash
```

## Pyenv

#### setup pyenv

```bash
# setup
sudo apt update && sudo apt upgrade -y
sudo apt-get install -y \
     libbz2-dev libdvd-pkg libffi-dev liblzma-dev libncurses5-dev \
     libncursesw5-dev libreadline-dev libsqlite3-dev libssl-dev \
     zlib1g-dev xz-utils llvm python3-openssl \
     build-essential make cmake ninja-build \
     libcriterion-dev ubuntu-restricted-extras
sudo dpkg-reconfigure libdvd-pkg
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
cd .pyenv/
src/configure && make -C src
```

#### install Python

```bash
# install Python
pyenv install --list | grep " 3\."
pyenv install 3.7 3.8 3.9 3.10 3.11
pyenv versions
pyenv global 3.11
pyenv which python
```

#### install clang
```bash
sudo apt-get install -y clang
```

## Fix scrolling

```bash
xinput list-props 13 | grep -i scrolling
xinput -set-prop 13 "libinput Scrolling Pixel Distance" 35
```

## Dotnet tools install commands

todo

## Vulkan

```bash
sudo apt update
sudo apt upgrade -y
sudo apt install build-essential -y 
sudo apt install vulkan-tools -y 
```

#### test with vkcube

```bash
echo "test with 'vkcube"
```

#### vulkan dev tools

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

## GLM, GLEW, SDL2
```bash
sudo apt-get update
sudo apt-get install libglm-dev
sudo apt-get install libglew-dev
sudo apt-get install libsdl2-dev
```


## Popular theme for qbittorrent

```bash
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
mkdir -p ~/opt/dracula/
cd ~/opt/dracula/
git clone https://github.com/dracula/qbittorrent.git
git clone https://github.com/dracula/gnome-terminal

chmod -R 777 qbittorrent
mod qbittorrent qbittorrent
cd qbittorrent/webui
cd ~/opt/dracula/qbittorrent/
make
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

#### install

```bash
sudo add-apt-repository multiverse && sudo apt-get update
sudo apt install virtualbox -y
```

#### Extension pack

```bash
sudo apt install virtualbox-ext-pack -y
```

#### remove

#### Uninstall extension package ?

```bash
sudo apt ins virtualbox-ext-pack -y
```

```bash
sudo apt remove virtualbox
sudo apt purge virtualbox
```

## Bitwarden (not finished)

```bash
sudo apt update -y && sudo apt upgrade -y
apt install apt-transport-https ca-certificates curl software-properties-common -y
```

## Spofiry

```bash
curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
```

```bash
sudo apt-get update && sudo apt-get install spotify-client -y
```


## Swap file

```bash
sudo fallocate -l 16G /swapfile
sudo chmod 600 /swapfile
ls -lh /swapfile

sudo mkswap /swapfile
sudo swapon /swapfile

sudo swapon --show
free -h
```

### Remove a swap file

```bash
swapoff -v /swapfile
rm -f /swapfile
```

## Install Alacritty

```bash
sudo apt update -y && sudo apt upgrade -y
sudo add-apt-repository ppa:aslatter/ppa -y
sudo apt install -y alacritty
sudo apt install -y cmake pkg-config libfreetype6-dev \
    libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
```

### Configure Rust on Ubuntu

```bash
sudo curl https://sh.rustup.rs -sSf | sh
```

### Download Alacritty Source code

```bash
git clone https://github.com/jwilm/alacritty.git
```

```bash
cd alacritty
cargo build --release
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
infocmp alacritty
```
### Create a Desktop shortcut

Once the installation process of building Alacritty source code is done, it will save the compiled binary under a directory, here is the path to that: /target/release/alacritty present under your Alacritty’s git cloned directory.

Without leaving Alacritty directory, run the given commands.

```bash
sudo cp target/release/alacritty /usr/local/bin

sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg

sudo desktop-file-install extra/linux/Alacritty.desktop

sudo update-desktop-database
```

### Shell completions

To get automatic completions for Alacritty’s flags and arguments you can install the provided shell completions.

```bash
echo "source $(pwd)/extra/completions/alacritty.bash" >> ~/.bashrc
```
### For Customization

To customize the look and feel of the Terminal, we can create Alacritty YML Configuration. You can get the default one here on Github.

or for the current one while doing the article use the given commands:
```bash

mkdir $HOME/.config/alacritty

cd $HOME/.config/alacritty

wget https://github.com/alacritty/alacritty/releases/download/v0.11.0-rc3/alacritty.yml
```

Now you have the file. Edit the same to configure the Terminal as per your choice.

```bash
$EDITOR $HOME/.config/alacritty/alacritty.yml
```

### Pre-built Terminal Themes

You can also, use the pre-built themes. For that you can use the NPM:

sudo apt install npm

Install Themes:

```bash
sudo npm i -g alacritty-themes

alacritty-themes
```
### Uninstall Alacritty from Ubuntu 22.04

Well, if you didn’t like this Terminal application then to remove Alacritty completely from your Ubuntu 22.04 system by following the given commands:

For PPA users:

```bash
sudo apt autoremove --purge alacritty
```

For source compiled users:

```bash
sudo rm /usr/local/bin/alacritty

sudo rm /usr/share/pixmaps/Alacritty.svg

sudo rm /usr/share/applications/Alacritty.desktop

sudo update-desktop-database
```

Also, delete the source code directory which you have cloned from GitHub.

## Gnome extensions

    sudo apt-get install -y gnome-tweaks \
        gnome-shell-extensions chrome-gnome-shell


## Minimize app window on dock click

    gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'

## Bitwarden and Zoom
sudo snap install -y bitwarden
sudo snap install -y zoom-client

## App preload predictor
sudo apt-get install -y preload

## Batery saver
sudo apt-get install -y tlp tlp-rdw
sudo systemctl enable tlp
sudo systemctl start tlp

## Manage free space and clear files
sudo apt-get install -y bleachbit

## Telegram
sudo apt-get install -y telegram-desktop

### Optional packages related to the Telegram Desktop messaging application
sudo apt install -y telegram-cli telegram-purple

## Free up space
https://askubuntu.com/questions/5980/how-do-i-free-up-disk-space
https://itsfoss.com/free-up-space-ubuntu-linux/

## How to Install Windows After Ubuntu Linux in Dual Boot
https://itsfoss.com/install-windows-after-ubuntu-dual-boot/


## Always show hidden files

```bash
gsettings set org.gnome.nautilus.preferences show-hidden-files true
```