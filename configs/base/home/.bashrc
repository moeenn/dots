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
eval "$(fzf --bash)"

shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize
shopt -s dotglob
shopt -s expand_aliases
shopt -s nocaseglob

alias :q="exit"
alias :Q="exit"
alias ls="ls -a"

alias g="git"
alias :s="git status"
alias :S="git status"
alias :c="git commit -m"
alias :C="git commit -m"
alias :b="git branch"
alias :B="git branch"
alias push="git push"
alias pull="git pull"
