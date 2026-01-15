# --------------------------------------------------------------------
#
#   shell colors and PS
#
# --------------------------------------------------------------------
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# PS1='${debian_chroot:+($debian_chroot)}\W$(parse_git_branch) \$  '
PS1='\W \[\e[0;$(($?==0?0:91))m\]$ \[\e[0m\]'

# --------------------------------------------------------------------
#
#   common settings and profile linking
#
# --------------------------------------------------------------------
test -s ${HOME}/.profile && . ${HOME}/.profile || true
eval "$(zoxide init bash)"


# --------------------------------------------------------------------
#
# general config.
#
# --------------------------------------------------------------------
shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize
shopt -s dotglob
shopt -s expand_aliases
shopt -s nocaseglob
bind '"\e[Z":menu-complete' # use Shift-tab to select tab suggestion.


# --------------------------------------------------------------------
#
#   command aliases.
#
# --------------------------------------------------------------------
# general operations.
alias cd="z"
alias :q="exit"
alias :Q="exit"
alias ls="ls -aC --color=never"
alias reload="source ~/.bashrc"

# programs.
alias k="kak"
alias rsync="rsync -av --progress"
alias load="htop -u $(whoami)"
alias df="dfc -f -s"
alias axel="axel -n 4"
alias uptime="uptime -p"
alias net="bwm-ng -t 1000"
alias lsblk="lsblk -e 7"
alias clock="tty-clock -cD"
alias cf="cfiles"
alias winclass="xprop WM_CLASS"
alias keyname="xev | grep keysym"

# super-user tasks.
alias full_access="sudo chmod -R a+rw ./"
alias mount="sudo mount -o rw"

# git.
alias :s="git status"
alias :S="git status"
alias :c="git commit -m"
alias :C="git commit -m"
alias :b="git branch"
alias :B="git branch"
alias push="git push"
alias pull="git pull"

# programming.
alias dc="docker-compose"
alias py="python3"
alias delete_dstore="find . -name '.DS_Store' -type f -delete -print"
alias valgrind="valgrind -s --leak-check=full --show-leak-kinds=all"
alias g="gradle" 
alias c="code"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
