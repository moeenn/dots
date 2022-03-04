# set env variables and aliases
test -s ${HOME}/.profile && . ${HOME}/.profile || true
test -s ${HOME}/.aliases && . ${HOME}/.aliases || true

# PS Colors
RS="\[\033[0m\]"    # reset
HC="\[\033[1m\]"    # hicolor
# UL="\[\033[4m\]"    # underline
# INV="\[\033[7m\]"   # inverse background and foreground
FBLK="\[\033[30m\]" # foreground black
# FRED="\[\033[31m\]" # foreground red
# FGRN="\[\033[32m\]" # foreground green
# FYEL="\[\033[33m\]" # foreground yellow
# FBLE="\[\033[34m\]" # foreground blue
# FMAG="\[\033[35m\]" # foreground magenta
FCYN="\[\033[36m\]" # foreground cyan
# FWHT="\[\033[37m\]" # foreground white
# BBLK="\[\033[40m\]" # background black
# BRED="\[\033[41m\]" # background red
# BGRN="\[\033[42m\]" # background green
# BYEL="\[\033[43m\]" # background yellow
# BBLE="\[\033[44m\]" # background blue
# BMAG="\[\033[45m\]" # background magenta
# BCYN="\[\033[46m\]" # background cyan
# BWHT="\[\033[47m\]" # background white

#PS1="\n\n$FBLE\u$FWHT in $FGRN\w \n$FWHT$ $RS "
PS1="\n$HC$ $FCYN\W $RS "

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
