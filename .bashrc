[ -n "$PS1" ] && source ~/.bash_profile

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting


# Set stdout buffer to 0
#line_buffer_so=$HOME/lib/line-buffer.so
#line-buffer-init()
#{
#  echo '__attribute__((constructor))void f(){setvbuf(stdout,NULL,_IOLBF,0);}' | gcc -s -include stdio.h -x c - -fPIC -shared -o "$line_buffer_so"
#}
#alias line-buffer="LD_PRELOAD='$line_buffer_so' "
