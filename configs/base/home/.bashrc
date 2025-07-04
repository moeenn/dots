# --------------------------------------------------------------------
#
#   shell colors and PS
#
# --------------------------------------------------------------------
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

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
