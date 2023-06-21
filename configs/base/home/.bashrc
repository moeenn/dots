# PS Colors
RS="\[\033[0m\]"    # reset
HC="\[\033[1m\]"    # hicolor
# UL="\[\033[4m\]"    # underline
# INV="\[\033[7m\]"   # inverse background and foreground
FBLK="\[\033[30m\]" # foreground black
# FRED="\[\033[31m\]" # foreground red
# FGRN="\[\033[32m\]" # foreground green
FYEL="\[\033[33m\]" # foreground yellow
FBLE="\[\033[34m\]" # foreground blue
# FMAG="\[\033[35m\]" # foreground magenta
FCYN="\[\033[36m\]" # foreground cyan
FWHT="\[\033[37m\]" # foreground white
# BBLK="\[\033[40m\]" # background black
# BRED="\[\033[41m\]" # background red
# BGRN="\[\033[42m\]" # background green
# BYEL="\[\033[43m\]" # background yellow
# BBLE="\[\033[44m\]" # background blue
# BMAG="\[\033[45m\]" # background magenta
# BCYN="\[\033[46m\]" # background cyan
# BWHT="\[\033[47m\]" # background white

PS1="\n$HC$FCYN\W $FBLE\$ $RS "

# link external config files
test -s ${HOME}/.profile && . ${HOME}/.profile || true

# Bash settings
shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize
shopt -s dotglob
shopt -s expand_aliases
shopt -s nocaseglob

# View the colors
function colors() {
  echo "  ";for i in {0..7}; do echo -en " \e[0;3${i}m████\e[0m"; done;
  echo "  ";for i in {0..7}; do echo -en " \e[1;3${i}m████\e[0m"; done; echo;
  echo "  "
}

# Aliases
alias ..="cd .."
alias cp="cp -v"
alias mv="mv -iv"
alias rm="rm -iv"
alias ls="ls -p --color=always"
alias lsa="ls -lpa | column -t"
alias :q="exit"
alias :Q="exit"
alias :s="git status"
alias :S="git status"
alias :c="git commit -m"
alias :C="git commit -m"
alias :b="git branch"
alias :B="git branch"
alias push="git push"
. "$HOME/.cargo/env"