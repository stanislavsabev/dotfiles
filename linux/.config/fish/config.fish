fish_config theme choose "Dracula Official"
set -U fish_greeting # Suppress fish's greeting

# ::env
set -gx HISTIGNORE " *"
set -gx HISTCONTROL ignoreboth:erasedups


set -gx CONFIG_DIR "$HOME/.config"
set -gx DOTFILES_DIR "$HOME/.dotfiles/linux"
set -gx EDITOR "code"
set -gx VENV_DIR ".venv"
set -gx PROJ_DIR "$HOME/projects"
set -gx OPT_DIR "$HOME/opt"
set -gx DEVSETUP_DIR "$HOME/$OPT_DIR/devsetup"


if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U status_ok 0
    set -U status_failed 1
    set -U status_failed 1
    set -U invalid_arguments 121
    set -U invalid_command_name 123
    set -U no_matches_found 124
    set -U could_not_execute_command 125
    set -U file_not_executable 126
    set -U function_builtin_or_command_not_located 127
end


# PARENT DIR NAVIGATION
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# LS ALIASES

alias bash="set MYSHELL bash; exec bash"

# alias ls="exa -GF"
alias ls='exa -a --color=always'
alias la='exa -lag --color=always'
alias ll="exa -lg --color=always"
alias ldir="exa -lgD"
alias lsdir="exa -lgD"
alias l.="exa -aF | egrep '^\.'"
alias ll.="exa -laF | awk '\$7 ~ /^\./'"
alias rf="rm -rf"
alias lt='exa -aT --color=always --group-directories-first' # tree listing

alias clear='echo -en "\x1b[2J\x1b[1;1H" ; echo; seq $(tput cols) | sort -R | spark | lolcat ; echo; echo'

# PYTHON VENV ALIASES
alias da="deactivate"
alias makevenv="python -m venv $VENV_DIR && va"
alias uppip="python -m pip install --upgrade pip"
alias pir="pip install -r "

# UTIL ALIASES
alias grephist="grephistory"

# DATETIME
alias week='date +%V'
alias utc="date -u +'%H:%M:%S UTC'"

# NAVIGATE ALIASES
alias home="cd"
alias dow="cd ~/Downloads"
alias doc="cd ~/Documents"
alias vid="cd ~/Videos"
alias p="cd $PROJ_DIR"
alias opt="cd $OPT_DIR"
alias dotfiles="cd $DOTFILES_DIR"
alias devsetup="cd $OPT_DIR/devsetup"
alias gitignore_global="cat $DEVSETU_DIR/gitignore_global"
alias gitconfig_local="cat .git/config"
alias gitconfig="cat $DOTFILES_DIR/gitconfig"
alias sand="cd $PROJ_DIR/sandbox_projects"

# OPEN WITH EDITOR
alias ed-aliases="$EDITOR $DOTFILES_DIR/aliases"
alias ed-history="$EDITOR $HOME/.bash_history"
alias ed-env="$EDITOR $DOTFILES_DIR/env"
alias ed-paths="$EDITOR $DOTFILES_DIR/paths"
alias ed-functions="$EDITOR $DOTFILES_DIR/functions"
alias ed-gitignore_global="$EDITOR $DEVSETU_DIR/gitignore_global"
alias ed-gitconfig="$EDITOR $DOTFILES_DIR/gitconfig"
alias ed-dotfiles="$EDITOR -n $DOTFILES_DIR/.."
alias ed-devsetup="$EDITOR -n $OPT_DIR/devsetup/ubuntu"
alias ed-fish="$EDITOR -n $CONFIG_DIR/fish"
alias ed-pysand="$EDITOR -n $PROJ_DIR/sandbox/pysandbox"
alias ed-vba-parser="$EDITOR -n $PROJ_DIR/vba_parser/main"

# APT
alias up="sudo apt update"
alias upup="sudo apt upgrade -y"
alias reboot="sudo reboot"

# GIT
alias g="git"

# WORKTREE FUNCTIONS
alias wt-ls="wtlist"
alias wt-co="wtcheckout"
alias wt-rm="wtremove"
alias wt-mv="wtmove"
alias wt-add="wtadd"
alias wt-add-ex="wtaddex"

clear
