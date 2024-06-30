source "$__fish_config_dir/conf.d/envs.fish"

alias chbash="set MYSHELL bash; exec bash"

# :NAVIGATION
alias ..="pushd .."
alias ...="pushd ../.."
alias ....="pushd ../../.."
alias ..ls="cdup_ls"
alias ..la="cdup_ls"
alias cdla="cdls"

abbr -a rf -- "rm -rf"

# alias cd="cdnvm"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"

# :COMMON DIRECTORIES
abbr -a dow -- 'pushd $HOME/Downloads'
abbr -a dtop -- 'pushd $HOME/Desktop'
abbr -a doc -- 'pushd $HOME/Documents'
abbr -a vid -- 'pushd $HOME/Videos'
abbr -a home -- "pushd ~"

abbr -a p -- 'pushd $PROJECTS_DIR'
abbr -a pls -- 'pushd $PROJECTS_DIR && la'
abbr -a dotdir 'pushd $DOTFILES_DIR'
abbr -a dot 'pushd $DOTFILES_DIR'
abbr -a dotfilesdir 'pushd $DOTFILES_DIR'
abbr -a fishdir -- 'pushd $__fish_config_dir'
abbr -a configdir -- 'pushd $HOME/.config'
abbr -a o -- 'open .'
abbr -a start -- 'open'
abbr -a pop -- 'popd'

# :PYTHON
abbr -a da -- deactivate
abbr -a uppip -- 'python -m pip install --upgrade pip'
abbr -a pir -- 'pip install -r'
abbr -a make-venv -- 'make_venv'
abbr -a make-va -- 'make_venv'

# :MY SCRIPTS
abbr -a --set-cursor nhistory -- "history % | nl"
abbr -a grephist -- 'grep_history'
abbr -a validate-commit-msg -- verify_commit_message
abbr -a pmlr -- 'pm ls -r'
abbr -a pmls -- 'pm ls'
abbr -a pmo -- 'pm open'
abbr -a kafka-up -- 'kafka_up'
abbr -a kafka-down -- 'kafka_down'


# :PROJ EDITING
abbr -a e -- $EDITOR
abbr -a ed-dotfiles -- '$EDITOR -n $DOTFILES_DIR'
abbr -a ed-fish -- '$EDITOR -n $__fish_config_dir'

# :COMMANDS
abbr -a reboot -- 'sudo reboot'
abbr -a --set-cursor ffind -- 'find . -type f -name "%" 2> /dev/null'
abbr -a --set-cursor dfind -- 'find . -type d -name "%" 2> /dev/null'
abbr -a codediff -- 'code --diff'
abbr -a codei -- 'code-insiders'
abbr -a ef -- 'exec fish'
abbr -a where -- 'which'
abbr -a unset 'set -e'

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
        abbr -a sand -- "pushd $PROJECTS_DIR/sandbox"
        abbr -a sandls -- "pushd $PROJECTS_DIR/sandbox && la"

        # APT
        abbr -a up -- "sudo apt update"
        abbr -a upg -- "sudo apt upgrade -y"
        abbr -a upup -- "sudo apt update && sudo apt upgrade -y"
        abbr -a api -- "sudo apt install"

        # OPEN WITH EDITOR
        abbr -a ed-history -- "$EDITOR $HOME/.bash_history"

        abbr -a htop -- "btop"

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
