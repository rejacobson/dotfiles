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
for f in ~/dotfiles/bash/*.bash; do
  echo "Including bash script: $f"
  . $f
done

# Use an existing ssh-agent or create a new one
sagent

echo "OS is: $platform"

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

# Get the name of the current git branch
function parse_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/▰ \1 ▰/'
}

# Shell Prompt
#export PROMPT_PWD="\[$bldblu\]\w\[$txtrst\]"
#export PROMPT_GIT_BRANCH="\[$txtred\]\$(parse_git_branch)\[$txtrst\]"
#export PROMPT_HOSTNAME="\[$bldblk\]\h\[$txtrst\]"
#export PROMPT_USER="\[$txtgrn\]\u"
#export PROMPT_ROOT_USER="\[\e[1;37;41m\] \u \[$txtrst\]"
#export END_OF_PROMPT_CHAR="\[\342\226\260\]"
#export END_OF_PROMPT="\[$bldblk\]$END_OF_PROMPT_CHAR\[$txtgrn\]$END_OF_PROMPT_CHAR\[$bldgrn\]$END_OF_PROMPT_CHAR\[$bldwht\]$END_OF_PROMPT_CHAR\[$txtrst\]"

if [ $(id -u) -eq 0 ]; then
  #export PS1="\n$PROMPT_PWD $PROMPT_GIT_BRANCH \n$PROMPT_ROOT_USER $PROMPT_HOSTNAME $END_OF_PROMPT "
  export PS1="\n\[$bldblu\]\w\[$txtrst\] \[$txtred\]\$(parse_git_branch)\[$txtrst\] \n\[\e[1;37;41m\] \u \[$txtrst\] \[$bldblk\]\h\[$txtrst\] \[$bldblk\]▰\[$txtgrn\]▰\[$bldgrn\]▰\[$bldwht\]▰\[$txtrst\] "
else
  #export PS1="\n$PROMPT_PWD $PROMPT_GIT_BRANCH \n$PROMPT_USER $PROMPT_HOSTNAME $END_OF_PROMPT "
  export PS1="\n\[$bldblu\]\w\[$txtrst\] \[$txtred\]\$(parse_git_branch)\[$txtrst\] \n\[$txtgrn\]\u \[$bldblk\]\h\[$txtrst\] \[$bldblk\]▰\[$txtgrn\]▰\[$bldgrn\]▰\[$bldwht\]▰\[$txtrst\] "
fi

###########################
# Aliases
###########################
if [[ "$platform" == 'osx' ]]; then
  alias la='ls -AlFhG'
else
  alias la='ls -AlFh --color=always'
fi

PATH=$HOME/bin:/usr/local/bin:$PATH

# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin 

# This loads RVM into a shell session.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

unset BUNDLE_GEMFILE
