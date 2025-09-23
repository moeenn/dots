# --------------------------------------------------------------------
#
#   shell colors and PS
#
# --------------------------------------------------------------------
RS="\[\033[0m\]"    # reset
HC="\[\033[1m\]"    # hicolor
FBLE="\[\033[34m\]" # foreground blue
FCYN="\[\033[36m\]" # foreground cyan
PS1="\n$HC$FCYN\W $FBLE\$ $RS "

# 
# --------------------------------------------------------------------
#
#   common settings and profile linking
#
# --------------------------------------------------------------------
test -s ${HOME}/.profile && . ${HOME}/.profile || true

shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize
shopt -s dotglob
shopt -s expand_aliases
shopt -s nocaseglob

alias :q="exit"
alias :Q="exit"
alias ls="ls -a"
