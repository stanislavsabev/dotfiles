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
alias fe="cd $FE_DIR"
alias soa="cd $SOA_DIR"
alias sql="cd $PROJECTS_DIR/sql"
alias dev="cd $PROJECTS_DIR/dev"
alias howto="cd $PROJECTS_DIR/howto"
alias dotfiles="cd $DOTFILES_DIR/.."

alias bels="cd $BE_DIR; wt ls"
alias migls="cd $MIGRATIONS_DIR; wt ls"
alias q2cls="cd $Q2C_DIR; wt ls"
alias fels="cd $FE_DIR; wt ls"
alias soals="cd $SOA_DIR; wt ls"

# :PYTHON
abbr -a da -- 'deactivate'
abbr -a pir -- 'pip install -r'
abbr -a uppip -- 'python -m pip install --upgrade pip'

# :SHOW/HIDE HIDDEN FILES
alias showhidden="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidehidden="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# :MY SCRIPTS
alias kport="kill_port"
alias service="source $SCRIPTS_DIR/start_service.sh"
alias grephist="grep_history"
alias autorebase-mig="python $SCRIPTS_DIR/autorebase_migrations_be.py"
alias expandalias="expand-alias"
abbr -a validate-commit-msg -- 'verify_commit_message'

# :SCRIPTS EDITING
alias ed=$EDITOR
alias ed-dotfiles="edproj -n ed-dotfiles -p $DOTFILES_DIR/.."
alias ed-fish="edproj -n ed-fish -p $__fish_config_dir"

# :PROJECTS EDITING
alias ed-be="edproj -n ed-be -p $BE_DIR"
alias ed-mig="edproj -n ed-mig -p $MIGRATIONS_DIR"
alias ed-soa="edproj -n ed-soa -p $SOA_DIR"
alias ed-sql="edproj -n ed-sql -p $PROJECTS_DIR/sql"
alias ed-dev="edproj -n ed-dev -p $PROJECTS_DIR/dev"
alias ed-pysand="edproj -n ed-pysand -p $PROJECTS_DIR/pysandbox"
alias ed-howto="edproj -n ed-howto -p $PROJECTS_DIR/howto"

# :Chrono
alias week='date +%V'
alias utc="date -u +'%H:%M:%S UTC'"
alias short-date="date +%Y-%m-%d"
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

# :Misc
alias brew='env PATH "($PATH//$(pyenv root)\/shims:/)" brew'

alias dbreset-mig="run_dbreset_be"
alias dbreset-be="run_dbreset_be"
alias dbreset-soa="run_dbreset_soa"

# :GIT
alias wt-ls="wt_list"
alias wt-co="wt_checkout"
alias wt-mv="wt_move"
alias wt-rm="wt_remove"
alias wt-add="wt_add"

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

abbr -a gdiff -- git diff
abbr -a gdiffhead -- git diff HEAD
abbr cdiff -a -- code --diff
abbr -a gwt -- git worktree

abbr -a pushmaster -- 'git push origin HEAD:refs/for/master'
abbr -a --set-cursor pushrefs -- 'git push origin HEAD:refs/for/%'

abbr -a cdtests -- 'cd ./tests/integration/src'

abbr -a soa-pythonpath -- 'set -gx PYTHONPATH $PYTHONPATH (pwd)/src'
abbr -a soa-source-cfg -- 'envsource ./configs/envs/local.env'
abbr -a soa-source-all -- 'set -gx PYTHONPATH $PYTHONPATH (pwd)/src && envsource ./configs/envs/local.env'