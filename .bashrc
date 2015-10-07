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

echo
echo '●▬▬▬▬▬▬๑۩۩๑▬▬▬▬▬▬▬●'
echo "   OS is: $platform"
echo '●▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬●'
echo

echo 'Includes'

############################
# Include Additional Scripts
############################
for f in ~/dotfiles/bash/*; do
  echo "  $f" | sed "s|$HOME|~|g"
  . $f
done

############################
# Include Non Version
# Controlled Scripts
############################
if [ -d ~/.bash ]; then
  for f in ~/.bash/*; do
    echo "  $f" | sed "s|$HOME|~|g"
    . $f
  done
fi

echo

# Use an existing ssh-agent or create a new one
sshagent_init

# Disable ctrl+s from sending XOFF
stty ixany
stty ixoff -ixon

# Default editor
export EDITOR='vim'
export TERM=xterm-color
export CLICOLOR=1
export LSCOLORS='Exfxcxdxbxegedabagacad'

##########################
# History
#########################
# Append to .bash_history, don't overwrite it
shopt -s histappend

# Maxiumum history file size
HISTFILESIZE=10000
HISTSIZE=10000

# Ignore commands that start with a space
# Ignore consecutive duplicate commands
HISTCONTROL=ignoreboth

# Write to history before each command is executed
PROMPT_COMMAND="history -a ; $PROMPT_COMMAND"

PATH=$HOME/bin:$HOME/dotfiles/bin:/usr/local/bin:$PATH

# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin

# This loads RVM into a shell session.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

unset BUNDLE_GEMFILE
