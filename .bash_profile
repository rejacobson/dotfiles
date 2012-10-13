############################
# Source .bashrc
############################
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

############################
# Detect the OS
############################
uname=$(uname)
case "$uname" in
   CYGWIN*) platform='cygwin' ;;
   Linux*) platform='linux' ;;
   Darwin*) platform='osx' ;;
   *)       platform='unknown' ;;
esac
echo "OS is: $platform"

if [[ "$platform" == 'cygwin' ]]; then
  SSHAGENT=/usr/bin/ssh-agent
  SSHAGENTARGS="-s"
  if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
    eval `$SSHAGENT $SSHAGENTARGS`
    trap "kill $SSH_AGENT_PID" 0
  fi
fi

############################
# Include Additional Scripts
############################
for f in ~/dotfiles/inc/*.bash; do
  echo "Including bash script: $f"
  . $f
done

# Default editor
export EDITOR='vim'

# ls Colors; directories are bold blue: 'Ex'
export LSCOLORS='Exfxcxdxbxegedabagacad'

# Get the name of the current git branch
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Shell Prompt
export PS1="\n\[${txtgrn}\]\w \[${txtpur}\]\$(parse_git_branch) \[${txtrst}\]\n\u \[${txtylw}\]\t\[${txtrst}\] \$ "

###########################
# Aliases
###########################
alias la='ls -AlFhG --color'
alias wget='curl -O'
alias j='cd ~/Projects/jigsy'
alias a='cd ~/Projects/asterion'

alias psa='a; passenger start -p 3002'
alias psj='j; passenger start'

# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin 

# This loads RVM into a shell session.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 
