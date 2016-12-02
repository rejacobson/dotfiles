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
for f in ~/dotfiles/bash.d/*; do
  . $f
done

############################
# Include Non Version
# Controlled Scripts
############################
if [ -d ~/.bash ]; then
  for f in ~/.bash/*; do
    . $f
  done
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
export MANPAGER=`which most`

# http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
shopt -s autocd # A command name that is the name of a dir is executed as, cd dir
shopt -s cdspell # Minor errors in the spelling of a directory will be corrected
shopt -s dirspell # Attempts spelling correction on directory names during word completion
shopt -s dotglob # Includes filenames beginning with a ‘.’ in the results of filename expansion
shopt -s histappend # Append to .bash_history, don't overwrite it
shopt -s nocaseglob # Matches filenames in a case-insensitive fashion when performing filename expansion

# Maxiumum history file size
HISTFILESIZE=10000
HISTSIZE=10000

# Ignore commands that start with a space
# Ignore consecutive duplicate commands
HISTCONTROL=ignoreboth

# Write to history before each command is executed
PROMPT_COMMAND="history -a ; $PROMPT_COMMAND"

PATH=$HOME/bin:$HOME/dotfiles/bin:/usr/local/bin:/usr/local/sbin:$PATH

unset BUNDLE_GEMFILE

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

~/dotfiles/bin/motd

