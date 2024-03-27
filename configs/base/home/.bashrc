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


# --------------------------------------------------------------------
#
#   command-line functions definitions
#
# --------------------------------------------------------------------
function colors() {
  echo "  ";for i in {0..7}; do echo -en " \e[0;3${i}m████\e[0m"; done;
  echo "  ";for i in {0..7}; do echo -en " \e[1;3${i}m████\e[0m"; done; echo;
  echo "  "
}


# --------------------------------------------------------------------
#
#   command aliases
#
# --------------------------------------------------------------------
alias pkg:update="sudo apt-get update"
alias pkg:search="apt-cache search"
alias pkg:install="sudo apt-get install -y"
alias pkg:remove="sudo apt-get remove"
alias pkg:upgrade="sudo apt-get upgrade -y"
alias pkg:purge_config="sudo dpkg --purge $(dpkg --get-selections | grep deinstall | cut -f1 )"
alias pkg:autoremove="sudo apt-get autoremove && pkg:purge_config"
alias pkg:clean="sudo apt-get autoclean; sudo apt-get clean"

# Operations
alias ..="cd .."
alias cp="cp -v"
alias mv="mv -iv"
alias rsync="rsync -avP"
alias rm="rm -iv"
alias link="ln -sr"
alias ls="ls -ap --color=always"
alias lsa="ls -alp"
alias :q="exit"
alias :Q="exit"

# Programs
alias load="htop -u moeenn"
alias df="dfc -f -s"
alias uptime="uptime -p"
alias extract="dtrx -v"
alias net="bwm-ng -t 1000"
alias speed="speedtest-rs"
alias lsblk="lsblk -e 7"
alias c="code ."
alias patch="patch -p1 <"
alias v="vim"
alias m="mpv"
alias t="tmux"

# Super User Tasks
alias kill="killall -v --ignore-case"
alias full_access="sudo chmod -R a+rw ./"

# git
alias :s="git status"
alias :S="git status"
alias :c="git commit -m"
alias :C="git commit -m"
alias :b="git branch"
alias :B="git branch"
alias push="git push"

# wifi management
alias wifi-scan="nmcli dev wifi list"
alias wifi-list="nmcli con show"
alias wifi-on="nmcli radio wifi on"
alias wifi-off="nmcli radio wifi off"
alias wifi-disconnect="nmcli con down"
alias wifi-connect="sudo nmcli con up"
# usage: wifi-connect <ssid> password <password>
alias wifi-add="sudo nmcli dev wifi connect"
alias wifi-delete="nmcli con delete"

# screen brightness
alias bright="sudo brightnessctl -d 'intel_backlight' -set"

# programming
alias dc="docker-compose"
alias py="python3"
