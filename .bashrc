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

if [[ "$platform" == 'cygwin' ]]; then
  SSHAGENT=/usr/bin/ssh-agent
  SSHAGENTARGS="-s"
  if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
    eval `$SSHAGENT $SSHAGENTARGS`
    trap "kill $SSH_AGENT_PID" 0
  fi
  ssh-add
elif [[ "$platform" == 'linux' ]]; then
  if [ -z "$SSH_AGENT_PID" ]; then
    exec ssh-agent $SHELL
  fi
fi

echo "OS is: $platform"

############################
# Include Additional Scripts
############################
for f in ~/dotfiles/bash/*.bash; do
  echo "Including bash script: $f"
  . $f
done


############################
# Include Non Version
# Controlled Scripts
############################
if [ -d ~/.bash ]; then
  for f in ~/.bash/*; do
    echo "Including bash script: $f"
    . $f
  done
fi

# Disable ctrl+s from sending XOFF
stty ixany
stty ixoff -ixon

# Default editor
export EDITOR='vim'

export CLICOLOR=1

export TERM=xterm-color

# ls Colors; directories are bold blue: 'Ex'
export LSCOLORS='Exfxcxdxbxegedabagacad'

# Get the name of the current git branch
function parse_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Shell Prompt
if [ $(id -u) -eq 0 ]; then
  export PS1="\n\[${bldblu}\]\w \[${txtpur}\]\$(parse_git_branch)\n\[\e[1;37;41m\] \u \[${txtrst}\]\[${txtylw}\]\t\[${txtrst}\] \[${bldblk}\]>\[${txtgrn}\]>\[${bldgrn}\]>\[${txtrst}\] "
else
  export PS1="\n\[${bldblu}\]\w \[${txtpur}\]\$(parse_git_branch) \[${txtrst}\]\n\u \[${txtylw}\]\t\[${txtrst}\] \[${bldblk}\]>\[${txtgrn}\]>\[${bldgrn}\]>\[${txtrst}\] "
fi

###########################
# Aliases
###########################
if [[ "$platform" == 'osx' ]]; then
  alias la='ls -AlFhG'
else
  alias la='ls -AlFh --color=always'
fi

PATH=/usr/local/bin:$PATH

# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin 

# This loads RVM into a shell session.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

unset BUNDLE_GEMFILE
