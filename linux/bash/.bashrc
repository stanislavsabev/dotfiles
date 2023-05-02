# ~/.bashrc: executed by bash(1) for non-login shells.

# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


# ::env
export DOTFILES_DIR="$HOME/.dotfiles/linux"
export SCRIPTS_DIR="$DOTFILES_DIR/bin"
export EDITOR=code
export VENV_DIR=".venv"
export PROJ_DIR="$HOME/projects"
export OPT_DIR="$HOME/opt"
export DEVSETUP_DIR="$HOME/$OPT_DIR/devsetup"
export CONFIG_DIR="$HOME/.config"
export XDG_CONFIG_HOME="$HOME/.config"

# ::endenv

# ::path
export PATH="$PATH:$SCRIPTS_DIR"              # my scripts
export PATH="$PATH:$HOME/.dotnet/tools"       # Add .NET Core SDK tools
export PATH="$PATH:$HOME/.cargo/bin"          # Add Rust tools

# ::endpath


# ::soruce files
for file in $DOTFILES_DIR/bash/{functions,aliases,prompt}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# source private files
if [ -d "$DOTFILES_DIR/bash/priv" ]; then
  for file in $DOTFILES_DIR/bash/priv/{envs,paths,vscode_functions,git_functions,functions,aliases,bash_prompt}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
  done;
fi
unset file;
# ::endsoruce files

# ::shopt
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTIGNORE=' *'
export HISTCONTROL=ignoreboth:erasedups
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# ::endshopt

# ::pyenv

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
# ::endpyenv

# ::fish shell

alias fish="export MYSHELL=fish; exec bash"

if [[ -z ${MYSHELL+x} ]]; then
  export MYSHELL="bash"
fi

if [[ $MYSHELL == "fish" ]]; then
  if command -v fish &> /dev/null
  then
      exec fish
  fi
fi
# ::endfish shell