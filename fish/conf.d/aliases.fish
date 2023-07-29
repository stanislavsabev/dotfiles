source "$__fish_config_dir/conf.d/envs.fish"

alias chbash="set MYSHELL bash; exec bash"

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

abbr -a p -- 'cd $PROJECTS_DIR'
abbr -a pls -- 'cd $PROJECTS_DIR && la'
abbr -a dotdir 'cd $DOTFILES_DIR'
abbr -a dotfilesdir 'cd $DOTFILES_DIR'
abbr -a fishdir -- 'cd $__fish_config_dir'
abbr -a configdir -- 'cd $HOME/.config'

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

# :COMMANDS
abbr -a reboot -- 'sudo reboot'
abbr -a c -- 'clear'
abbr -a o -- 'open .'
abbr -a --set-cursor ffile -- 'find . -type f -name "%" 2> /dev/null'
abbr -a --set-cursor fdir -- 'find . -type d -name "%" 2> /dev/null'

# :GIT
abbr -a add -- 'git add -- '
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
abbr -a unstage -- 'git reset -- '
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
abbr -a codei -- 'code-insiders'
abbr -a gwt -- 'git worktree'
abbr -a changed -- "git diff HEAD HEAD^ --name-only"

abbr -a pushmaster -- 'git push origin HEAD:refs/for/master'
abbr -a pushmain -- 'git push origin HEAD:refs/for/main'
abbr -a --set-cursor pushrefs -- 'git push origin HEAD:refs/for/%'

abbr -a ef -- 'exec fish'

switch (uname)
    case Linux

        # LS ALIASES
        # alias ls="exa -GF"
        alias exa='exa --color=always'
        alias l='exa -g'
        alias ls='exa -ag'
        abbr -a lsgrep -- 'ls | grep'
        alias la='exa -lag'
        alias ll='exa -lg'
        abbr -a ldir -- "exa -lgD"
        abbr -a lsdir -- "exa -lgD"
        alias l.="exa -d (exa -a --color=never | egrep '^\.') "
        alias ls.="exa -dF (exa -a --color=never | egrep '^\.')"
        alias la.="exa -ldgF (exa -a --color=never | egrep '^\.')"
        alias rf="rm -rf"
        # tree listing
        abbr lt -- 'exa -aT --group-directories-first'
        
        abbr -a sand -- "cd $PROJECTS_DIR/sandbox"
        abbr -a sandls -- "cd $PROJECTS_DIR/sandbox && la"

        # APT
        abbr -a up -- "sudo apt update -y"
        abbr -a upup -- "sudo apt upgrade -y"
        abbr -a api -- "sudo apt install"

        # OPEN WITH EDITOR
        abbr -a ed-history -- "$EDITOR $HOME/.bash_history"
        abbr -a ed-pysand -- "$EDITOR -n $PROJECTS_DIR/sandbox/pysand"
        abbr -a ed-vba-parser -- "$EDITOR -n $PROJECTS_DIR/vba_parser/main"



    case Darwin

        # :SHORTHAND COMMANDS
        abbr -a l -- "ls -F"
        abbr -a ls -- "ls -lAh"
        abbr -a la -- "ls -lAh"
        abbr -a ll -- "ls -lh"
        abbr -a lh -- "ls -lh"
        abbr -a l. -- "ls -d .*"
        abbr -a la. -- "ls -lAh | awk '\$NF ~ /^\./'"
        abbr -a ll. -- "ls -lAh | awk '\$NF ~ /^\./'"


        alias brew='env PATH "($PATH//$(pyenv root)\/shims:/)" brew'

        # :MY SCRIPTS
        alias kports="kill_ports"
        alias lsports="ls_ports"
        alias service="source $SCRIPTS_DIR/start_service.sh"

        # :Chrono
        abbr -a week -- 'date +%V'
        abbr -a utc -- "date -u +'%H:%M:%S UTC'"
        abbr -a short-date -- "date +%Y-%m-%d"
        abbr -a chrome -- '/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

        # :SHOW/HIDE HIDDEN FILES
        alias showhidden="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
        alias hidehidden="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

end
