source ~/.config/fish/conf.d/envs.fish

alias bash="set MYSHELL bash; exec bash"

# :NAVIGATION
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ..ls="cdup_ls"
alias ..la="cdup_ls"
alias cdla="cdls"

# :SHORTHAND COMMANDS
alias l="ls -CF"
alias la="ls -lAh"
alias ll="ls -lh"
alias lh="ls -lh"
alias l.="ls -d .*"
alias la.="ls -lAh | awk '\$NF ~ /^\./'"
alias ll.="ls -lAh | awk '\$NF ~ /^\./'"
alias rf="rm -rf"
alias rm="rm -i"
alias mv="mv -i"

# alias cd="cdnvm"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"

# :COMMON DIRECTORIES
alias dow="cd ~/Downloads"
alias dtop="cd ~/Desktop"
alias doc="cd ~/Documents"
alias cfg="cd ~/.config"
alias home="cd"

alias p="cd $PROJECTS_DIR"
alias be="cd $BE_DIR"
alias mig="cd $MIGRATIONS_DIR"
alias q2c="cd $Q2C_DIR"
alias be-cd-tests="cd ./tests/integration/src"
alias fe="cd $FE_DIR"
alias soa="cd $SOA_DIR"
alias sql="cd $PROJECTS_DIR/sql"
alias dev="cd $PROJECTS_DIR/dev"

# :PYTHON
alias da="deactivate"
alias pir="pip install -r"
alias uppip="python -m pip install --upgrade pip"

# :SHOW/HIDE HIDDEN FILES
alias showhidden="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidehidden="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# :MY SCRIPTS
alias kport="source $DOTFILES_DIR/bin/kill_port.sh"
alias service="source $DOTFILES_DIR/bin/start_service.sh"
alias grephist="grep_history"
alias rebase-mig="python $SCRIPTS_DIR/rebase.py"
alias expandalias="expand-alias"
alias validate-commit-msg="verify-commit-msg"

# :SCRIPTS EDITING
alias ed-dotfiles="$EDITOR -n $DOTFILES_DIR/.."
alias ed-fish="$EDITOR -n $CONFIG_DIR/fish"

# :PROJECTS EDITING
alias ed-be="$EDITOR -n $BE_DIR"
alias ed-mig="$EDITOR -n $MIGRATIONS_DIR"
alias ed-soa="$EDITOR -n $SOA_DIR"
alias ed-sql="$EDITOR -n $PROJECTS_DIR/sql"
alias ed-dev="$EDITOR -n $PROJECTS_DIR/dev"
alias ed-pysand="$EDITOR $PROJECTS_DIR/pysandbox"

# :Chrono
alias week='date +%V'
alias utc="date -u +'%H:%M:%S UTC'"
alias short-date="date +%Y-%m-%d"
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

# :Misc
alias brew='env PATH="($PATH//$(pyenv root)\/shims:/)" brew'

alias soapythonpath='set -gx PYTHONPATH $PYTHONPATH $(pwd)/src'
alias sourcesoacfg="envsource ./configs/envs/local.env"

# :GIT
alias wt-ls="wtlist"
alias wt-co="wtcheckout"
alias wt-mv="wtmove"
alias wt-rm="wtremove"
alias wt-add="wtadd"

alias add="git add --"
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
