# Use an existing ssh-agent or create a new one
. ~/dotfiles/bash/sshagent
sshagent_init

############################
# Detect the OS
############################
uname=$(uname)
case "$uname" in
   CYGWIN*) platform='cygwin' ;;
   Linux*)  platform='linux' ;;
   Darwin*) platform='osx' ;;
   *)       platform='unknown' ;;
esac

############################
# Include Additional Scripts
############################
if [ "$(ls -A ~/dotfiles/bash.d/)" ]; then
  for f in ~/dotfiles/bash.d/*; do
    . $f
  done
fi

############################
# Include Non Version
# Controlled Scripts
############################
if [ -d ~/.bash ]; then
  if [ "$(ls -A ~/.bash/)" ]; then
    for f in ~/.bash/*; do
      echo "$f"
      . $f
    done
  fi
fi

# Load ls colors
loadlscolors

# Disable ctrl+s from sending XOFF
[[ $- == *i* ]] && stty ixany
[[ $- == *i* ]] && stty ixoff -ixon

# Default editor
export EDITOR='vim'
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS='Exfxcxdxbxegedabagacad'
export MANPAGER=$(if command -v most >/dev/null; then echo -n `which most`; else echo -n `which less`; fi)

# http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
shopt -s autocd # A command name that is the name of a dir is executed as, cd dir
shopt -s cdspell # Minor errors in the spelling of a directory will be corrected
shopt -s dirspell # Attempts spelling correction on directory names during word completion
shopt -s dotglob # Includes filenames beginning with a ‘.’ in the results of filename expansion
shopt -s nocaseglob # Matches filenames in a case-insensitive fashion when performing filename expansion

# Eternal bash history.
# https://stackoverflow.com/a/19533853/834258
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
HISTFILESIZE=
HISTSIZE=
HISTTIMEFORMAT='[%F %T] '

# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
HISTFILE=~/.bash_eternal_history

# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Ignore commands that start with a space
# Ignore consecutive duplicate commands
HISTCONTROL=ignoreboth

PATH="$HOME/bin:$HOME/dotfiles/bin:/usr/local/bin:/usr/local/sbin:$PATH"

if [[ $platform = 'osx' ]]; then
  PATH="/opt/homebrew/bin:$PATH"
fi

unset BUNDLE_GEMFILE

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [[ ! -z "$(which rbenv)" ]]; then
  eval "$(rbenv init - bash)"
fi

~/dotfiles/bin/motd

