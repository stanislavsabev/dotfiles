source "$__fish_config_dir/conf.d/envs.fish"

alias bash="set MYSHELL bash; exec bash"

# :NAVIGATION
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ..ls="cdup_ls"
alias ..la="cdup_ls"
alias cdla="cdls"

abbr -a rf -- "rm -rf"
abbr -a rm -- "rm -i"
abbr -a mv -- "mv -i"

# alias cd="cdnvm"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"

# :COMMON DIRECTORIES
abbr -a dow -- 'cd $HOME/Downloads'
abbr -a dtop -- 'cd $HOME/Desktop'
abbr -a doc -- 'cd $HOME/Documents'
abbr -a vid -- 'cd $HOME/Videos'
abbr -a home -- cd

abbr -a p -- 'cd $PROJECTS_DIR && ls'
abbr -a dotfiles 'cd $DOTFILES_DIR'
abbr -a config -- 'cd $HOME/.config'

abbr -a pls -- 'cd $PROJECTS_DIR && ls'


# :PYTHON
abbr -a da -- deactivate
abbr -a uppip -- 'python -m pip install --upgrade pip'
abbr -a pir -- 'pip install -r'

# :MY SCRIPTS
abbr -a grephist -- 'grep_history'
abbr -a validate-commit-msg -- verify_commit_message

# :PROJ EDITING
abbr -a e -- $EDITOR
abbr -a ed-dotfiles -- '$EDITOR -n $DOTFILES_DIR'
abbr -a ed-fish -- '$EDITOR -n $__fish_config_dir'
abbr -a cd-fish -- 'cd $__fish_config_dir'

abbr -a reboot -- 'sudo reboot'

# :GIT
# alias wt-ls='wt_list'
# alias wt-co='wt_checkout'
# alias wt-mv='wt_move'
# alias wt-rm='wt_remove'
# alias wt-add='wt_add'

abbr -a add -- 'git add'
abbr -a addall -- 'git add --all'
abbr -a push -- 'git push'
abbr -a pull -- 'git pull'
abbr -a fetch -- 'git fetch --all'
abbr -a rebase -- 'git rebase'
abbr -a --set-cursor cam -- 'git add --all && git commit -am "%"'
abbr -a --set-cursor ca -- 'git add --all && git commit -a'
abbr -a --set-cursor cm -- 'git commit -m "%"'
abbr -a commit -- 'git commit'
abbr -a stash -- 'git stash'
abbr -a remote -- 'git remote'

abbr -a s -- 'git status'
abbr -a sv -- 'git status -v'
abbr -a b -- 'git branch'
abbr -a cleanf -- 'git clean -f'
abbr -a checkout -- 'git checkout'
abbr -a co -- 'git checkout'
abbr -a curr-branch -- 'git rev-parse --abbrev-ref HEAD'

abbr -a undolast -- 'git reset HEAD~1'
abbr -a unstageall -- 'git reset -- .'
abbr -a recommit -- 'commit -c ORIG_HEAD'
abbr -a resethard -- 'git reset HEAD --hard'
abbr -a resetall -- 'git reset HEAD --hard && git clean -f'
abbr -a amend -- 'git commit --amend'
abbr -a cnoe -- 'git commit --amend --no-edit'
abbr -a acnoe -- 'git add --all && git commit --amend --no-edit'
abbr -a logv -- 'git log'

set -gx __git_log_format "format:'%C(yellow)%h%Creset %<(65,trunc)%s - %C(bold blue)%<(7,trunc)%an%Creset %C(bold red)%d %Creset%C(green)(%cr)'"

alias lv='git log'
alias lg="git log --graph --pretty=$__git_log_format --abbrev-commit"

abbr -a lgmy -- 'git log --graph --pretty=$__git_log_format --abbrev-commit --author=\'ssabev\''
abbr -a --set-cursor lgauth -- 'git log --graph --pretty=$__git_log_format --abbrev-commit --author=%'
abbr -a log -- 'git log --graph --pretty=$__git_log_format --abbrev-commit'
abbr -a lgstat -- 'git log --graph --pretty=$__git_log_format --abbrev-commit --stat'
abbr -a lgst -- 'git log --graph --pretty=$__git_log_format --abbrev-commit --stat'
abbr -a logstat -- 'git log --graph --pretty=$__git_log_format --abbrev-commit --stat'
abbr -a logsha -- "git log --pretty=format:'%H'"
abbr -a lgsha -- "git log --pretty=format:'%H'"
abbr -a sha -- "git log -1 --pretty=format:'%H'"
abbr -a longsha -- "git log -1 --pretty=format:'%H'"
abbr -a shortsha -- "git log -1 --pretty=format:'%h'"
abbr -a stat -- "git diff HEAD~1 HEAD --stat"

abbr -a gdiff -- 'git diff'
abbr -a gdiffhead -- 'git diff HEAD'
abbr -a cdiff -- 'code --diff'
abbr -a gwt -- 'git worktree'

abbr -a pushmaster -- 'git push origin HEAD:refs/for/master'
abbr -a pushmain -- 'git push origin HEAD:refs/for/main'
abbr -a --set-cursor pushrefs -- 'git push origin HEAD:refs/for/%'

switch (uname)
    case Linux

        # LS ALIASES
        # alias ls="exa -GF"
        alias exa='exa --color=always'
        alias l='exa -a'
        alias ls='exa -lag'
        alias la='exa -lag'
        alias ll='exa -lg'
        abbr -a ldir -- "exa -lgD"
        abbr -a lsdir -- "exa -lgD"
        abbr -a l. -- "exa -aF | egrep '^\.'"
        abbr -a ll. -- "exa -laF | awk '\$7 ~ /^\./'"
        abbr -a rf -- "rm -rf"
        # tree listing
        abbr lt -- 'exa -aT --group-directories-first'
        
        abbr -a sand -- "cd $PROJECTS_DIR/sandbox && la"


        # APT
        abbr -a up -- "sudo apt update"
        abbr -a upup -- "sudo apt upgrade -y"
        abbr -a api -- "sudo apt install"

        # OPEN WITH EDITOR
        abbr -a ed-history -- "$EDITOR $HOME/.bash_history"
        abbr -a ed-pysand -- "$EDITOR -n $PROJECTS_DIR/sandbox/pysand"
        abbr -a ed-vba-parser -- "$EDITOR -n $PROJECTS_DIR/vba_parser/main"



    case Darwin

        # :SHORTHAND COMMANDS
        abbr -a l -- "ls -CF"
        abbr -a la -- "ls -lAh"
        abbr -a ll -- "ls -lh"
        abbr -a lh -- "ls -lh"
        abbr -a l. -- "ls -d .*"
        abbr -a la. -- "ls -lAh | awk '\$NF ~ /^\./'"
        abbr -a ll. -- "ls -lAh | awk '\$NF ~ /^\./'"


        alias brew='env PATH "($PATH//$(pyenv root)\/shims:/)" brew'

        abbr -a be -- "cd $BE_DIR"
        abbr -a mig -- "cd $MIGRATIONS_DIR"
        abbr -a q2c -- "cd $Q2C_DIR"
        abbr -a fe -- "cd $FE_DIR"
        abbr -a soa -- "cd $SOA_DIR"
        abbr -a sql -- "cd $PROJECTS_DIR/sql"
        abbr -a dev -- "cd $PROJECTS_DIR/dev"
        abbr -a howto -- "cd $PROJECTS_DIR/howto"
        abbr -a bels -- "cd $BE_DIR; wt ls"
        abbr -a migls -- "cd $MIGRATIONS_DIR; wt ls"
        abbr -a q2cls -- "cd $Q2C_DIR; wt ls"
        abbr -a fels -- "cd $FE_DIR; wt ls"
        abbr -a soals -- "cd $SOA_DIR; wt ls"

        alias ed-be="edproj -n ed-be -p $BE_DIR"
        alias ed-mig="edproj -n ed-mig -p $MIGRATIONS_DIR"
        alias ed-soa="edproj -n ed-soa -p $SOA_DIR"
        alias ed-sql="edproj -n ed-sql -p $PROJECTS_DIR/sql"
        alias ed-dev="edproj -n ed-dev -p $PROJECTS_DIR/dev"
        alias ed-pysand="edproj -n ed-pysand -p $PROJECTS_DIR/pysandbox"
        alias ed-howto="edproj -n ed-howto -p $PROJECTS_DIR/howto"

        abbr -a dbreset-mig -- 'run_dbreset_be'
        abbr -a dbreset-be -- 'run_dbreset_be'
        abbr -a dbreset-soa -- 'run_dbreset_soa'

        abbr -a cdtests -- 'cd ./tests/integration/src'

        abbr -a soa-pythonpath -- 'set -gx PYTHONPATH $PYTHONPATH (pwd)/src'
        abbr -a soa-source-cfg -- 'envsource ./configs/envs/local.env'
        abbr -a soa-source-all -- 'set -gx PYTHONPATH $PYTHONPATH (pwd)/src && envsource ./configs/envs/local.env'

        # :MY SCRIPTS
        alias kport="kill_port"
        alias service="source $SCRIPTS_DIR/start_service.sh"
        abbr -a autorebase-mig -- 'python $SCRIPTS_DIR/autorebase_migrations_be.py'


        # :Chrono
        abbr -a week -- 'date +%V'
        abbr -a utc -- "date -u +'%H:%M:%S UTC'"
        abbr -a short-date -- "date +%Y-%m-%d"
        abbr -a chrome -- '/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

        # :SHOW/HIDE HIDDEN FILES
        alias showhidden="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
        alias hidehidden="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

end
