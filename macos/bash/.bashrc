
# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
# ::fish shell
alias fish="export MYSHELL=fish; exec bash"

if [[ -z ${MYSHELL+x} ]]; then
  export MYSHELL="fish"
fi

if [[ $MYSHELL == "fish" ]]; then
  if command -v fish &> /dev/null
  then
      exec fish
  fi
fi
# ::endfish shell

export DOTFILES_DIR="$HOME/.dotfiles/macos"

for file in $DOTFILES_DIR/bash/{envs,paths,vscode_functions,git_functions,functions,aliases,bash_prompt}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

# source private files
if [ -d "$DOTFILES_DIR/bash/priv" ]; then
  for file in $DOTFILES_DIR/bash/priv/{envs,paths,vscode_functions,git_functions,functions,aliases,bash_prompt}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
  done;
fi
unset file;

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if [ -f "$DOTFILES_DIR/bash/.git-completion.bash" ]; then
  . "$DOTFILES_DIR/bash/.git-completion.bash"
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/google-cloud-sdk/path.bash.inc' ]; then . '~/google-cloud-sdk/path.bash.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '~/google-cloud-sdk/completion.bash.inc' ]; then . '~/google-cloud-sdk/completion.bash.inc'; fi


cd "$PWD"
