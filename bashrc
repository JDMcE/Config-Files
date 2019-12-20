# .bashrc
 
# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
 
# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH
 
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
 
# User specific aliases and functions
 
#-------------
# Aliases
#-------------
 
alias ls='ls -lAF --color'
alias ..='cd ..'
alias c='clear'
alias yum='yum -y'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias wget='wget -c'
alias top='htop'
alias h='history'
alias path='echo -e ${PATH//:/\\n}'
alias du='du -kh'
alias df='df -kTh --total'
alias ps='ps auxf'
 
#-------------
# Functions
#------------
 
# Append to hist file
shopt -s histappend
 
HISTSIZE=1000
HISTFILESIZE=2000
 
mcd () {
    mkdir -p $1
    cd $1
}
 
function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
 else
    for n in $@
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}
 
 
#------------
# Prompt
#------------
 
export PS1="\[\e[31m\]\u\[\e[m\] \[\e[36m\]\w\[\e[m\] \[\e[32m\]\\$\[\e[m\] "