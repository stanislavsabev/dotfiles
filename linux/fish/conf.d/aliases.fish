source "$HOME/.config/fish/conf.d/envs.fish"

alias bash="set MYSHELL bash; exec bash"

# :NAVIGATION
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ..ls="cdup_ls"
alias ..la="cdup_ls"
alias cdla="cdls"

# LS ALIASES
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

# :SHORTHAND COMMANDS
alias rf="rm -rf"
alias rm="rm -i"
alias mv="mv -i"

# alias cd="cdnvm"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"

# :PYTHON
alias da="deactivate"
alias uppip="python -m pip install --upgrade pip"
alias pir="pip install -r"

# :MY SCRIPTS
alias grephist="grep_history"
alias kport="source $SCRIPTS_DIR/kill_port.sh"
alias service="source $SCRIPTS_DIR/start_service.sh"
alias rebase-mig="python $SCRIPTS_DIR/rebase.py"
alias expandalias="expand-alias"
alias validate-commit-msg="verify-commit-msg"

# :SCRIPTS EDITING
alias ed-dotfiles="edproj -n ed-dotfiles -p $DOTFILES_DIR/.."
alias ed-fish="edproj -n ed-fish -p $__fish_config_dir"

# :Chrono
alias week='date +%V'
alias utc="date -u +'%H:%M:%S UTC'"
alias short-date="date +%Y-%m-%d"
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

# NAVIGATE ALIASES
alias home="cd"
alias dow="cd ~/Downloads"
alias doc="cd ~/Documents"
alias vid="cd ~/Videos"
alias p="cd $PROJ_DIR"
alias opt="cd $OPT_DIR"
alias cfg="cd ~/.config"
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


# WORKTREE FUNCTIONS
alias wt-ls="wtlist"
alias wt-co="wtcheckout"
alias wt-rm="wtremove"
alias wt-mv="wtmove"
alias wt-add="wtadd"

alias add="git add"
alias addall="git add --all"
alias push="git push"
alias rebase="git rebase"
alias pull="git pull"
alias fetch="git fetch --all"
alias addall="git add --all"
alias cam="git commit -am"
alias cm="git commit -m"
alias commit="git commit"
alias stash="git stash"
alias remote="git remote"
# alias status="git status"
alias statusv="git status -v"
alias s="git status"
alias sv="git status -v"
alias b="git branch"
alias cleanf="git clean -f"
alias checkout="git checkout"
alias co="git checkout"
alias curr-branch="git rev-parse --abbrev-ref HEAD"
alias undolast="git reset HEAD~1"
alias unstageall="git reset -- ."
alias recommit="commit -c ORIG_HEAD"
alias resethard="git reset HEAD --hard"
alias resetall="git reset HEAD --hard && git clean -f"
alias amend="git commit --amend"
alias cnoe="git commit --amend --no-edit"
alias acnoe="git add --all && git commit --amend --no-edit"
alias pushmaster="git push origin HEAD:refs/for/master"
alias pushrefsfor="push-refs-for"
alias logv="git log"
alias lv="git log"
set __fmt "format:'%C(yellow)%h%Creset %<(65,trunc)%s - %C(bold blue)%<(7,trunc)%an%Creset %C(bold red)%d %Creset%C(green)(%cr)'"
alias lg="git log --graph --pretty=$__fmt --abbrev-commit"
alias lgmy="git log --graph --pretty=$__fmt --abbrev-commit --author='ssabev' "
alias lgauth="git log --graph --pretty=$__fmt --abbrev-commit --author"
alias log="git log --graph --pretty=$__fmt --abbrev-commit"
alias lgstat="git log --graph --pretty=$__fmt --abbrev-commit --stat"
alias lgst="git log --graph --pretty=$__fmt --abbrev-commit --stat"
alias logstat="git log --graph --pretty=$__fmt --abbrev-commit --stat"
alias logsha="git log --pretty=format:'%H'"
alias lgsha="git log --pretty=format:'%H'"
alias sha="git log -1 --pretty=format:'%H'"
alias longsha="git log -1 --pretty=format:'%H'"
alias shortsha="git log -1 --pretty=format:'%h'"
alias stat="git diff HEAD~1 HEAD --stat"
alias diff="git diff"
alias diffhead="git diff HEAD"
