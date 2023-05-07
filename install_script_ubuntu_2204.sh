#!/usr/bin/env bash

echo ">> Run install script for Ubuntu 22.04 LTS"

sudo apt-get update -y
sudo apt-get upgrade -y

echo ">> Install additional dev libs"

sudo apt-get install -y \
     libbz2-dev libdvd-pk libffi-dev liblzma-dev libncurses5-dev \
     libncursesw5-dev libreadline-dev libsqlite3-dev libssl-dev \
     zlib1g-dev xz-utils llvm python3-openssl \
     build-essential make cmake

sudo apt-get install -y \
     curl wget htop tk-dev git tmux vim exa wine
sudo apt-get update -y

## qbittorrent, vlc
echo "Install qbittorrent, vlc"
sudo apt-get install -y qbittorrent 
sudo sudo apt-get install vlc -y
sudo apt install -y vlc-plugin-access-extra libbluray-bdj libdvd-pkg 
sudo apt install -y vlc-plugin-bittorrent


## Dracula themes
echo ">> Add Dracula terminal profile"

# Create Dracula profile
dconfdir=/org/gnome/terminal/legacy/profiles:
create_gnome_term_profile() {
    local profile_ids=($(dconf list $dconfdir/ | grep ^: |\
                        sed 's/\///g' | sed 's/://g'))
    local profile_name="$1"
    local profile_ids_old="$(dconf read "$dconfdir"/list | tr -d "]")"
    local profile_id="$(uuidgen)"

    [ -z "$profile_ids_old" ] && local profile_ids_old="["  # if there's no `list` key
    [ ${#profile_ids[@]} -gt 0 ] && local delimiter=,  # if the list is empty
    dconf write $dconfdir/list \
        "${profile_ids_old}${delimiter} '$profile_id']"
    dconf write "$dconfdir/:$profile_id"/visible-name "'$profile_name'"
    echo $profile_id
}
UUID=$(create_gnome_term_profile Dracula)
dconf write $dconfdir/default "'$UUID'"

# Add Dracula themes
echo ">> Install Dracula themes"
mkdir -p ~/opt/dracula
cd ~/opt/dracula/
git clone https://github.com/dracula/qbittorrent.git
# TODO: install qbittorrent theme

git clone https://github.com/dracula/gnome-terminal
cd gnome-terminal
./install.sh -s Dracula -p Dracula --install-dircolors

cd ~/opt
git clone https://github.com/jagannatharjun/qbt-theme.git
# TODO: install qbt-theme
cd ~

## Pyenv
echo ">> Install Pyenv"

sudo apt-get install -y make build-essential libssl-dev \
    zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget \
    curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev \
    libffi-dev liblzma-dev python3-openssl libdvd-pkg
sudo apt-get update -y

cd ~
sudo dpkg-reconfigure libdvd-pkg
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
cd .pyenv/
src/configure && make -C src
cd ~
pyenv install 3.7 3.8 3.9 3.10 3.11
pyenv global 3.11


echo ">> Install fish shell"
cd ~
sudo apt-add-repository -y ppa:fish-shell/release-3
sudo apt-get update -y
sudo apt-get install fish

cd ~/.config
sudo apt-get update
curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install > install
fish install
cd ~

## VSCode
echo ">> Install VSCode (no snap)"

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor > packages.microsoft.gpg
sudo apt-get install software-properties-common apt-transport-https wget gpg -y
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get update -y
sudo apt-get install code

## Firefox
echo ">> Install Forefox (no snap)"
sudo snap remove firefox --purge
sudo add-apt-repository -y ppa:mozillateam/ppa

echo '
Package: firefox*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001

Package: firefox*
Pin: release o=Ubuntu*
Pin-Priority: -1
' | sudo tee /etc/apt/preferences.d/mozilla-firefox

echo \
    'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | \
    sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox
sudo apt-get update -y
sudo apt-get -y install firefox

## Swap file
echo ">> Setup swap file"
sudo fallocate -l 16G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show
free -h

echo ">> Success. Installation script finished without errors!"
