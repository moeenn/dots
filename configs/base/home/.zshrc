# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# --------------------------------------------------------------------
#
#   Shell Aliases
#
# --------------------------------------------------------------------
# package management
alias pkg:update="sudo apt-get update"
alias pkg:search="apt-cache search"
alias pkg:install="sudo apt-get install -y"
alias pkg:remove="sudo apt-get remove"
alias pkg:upgrade="sudo apt-get upgrade -y"
alias pkg:purge_config="sudo dpkg --purge $(dpkg --get-selections | grep deinstall | cut -f1 )"
alias pkg:autoremove="sudo apt-get autoremove && pkg:purge_config"
alias pkg:clean="sudo apt-get autoclean; sudo apt-get clean"

# Operations
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
alias load="htop -u $(whoami)"
alias df="dfc -f -s"
alias uptime="uptime -p"
alias extract="dtrx -v"
alias net="bwm-ng -t 1000"
alias lsblk="lsblk -e 7"
alias c="code ."
alias patch="patch -p1 <"
alias v="vim"
alias m="mpv"

# Super User Tasks
alias kill="killall -v --ignore-case"
alias full_access="sudo chmod -R a+rw ./"

# tmux
alias t="tmux"
alias att="tmux attach -t default"

# git
alias :s="git status"
alias :S="git status"
alias :c="git commit -m"
alias :C="git commit -m"
alias :b="git branch"
alias :B="git branch"
alias push="git push"

# wifi management
#alias wifi-scan="nmcli dev wifi list"
#alias wifi-list="nmcli con show"
#alias wifi-on="nmcli radio wifi on"
#alias wifi-off="nmcli radio wifi off"
#alias wifi-disconnect="nmcli con down"
#alias wifi-connect="sudo nmcli con up"

# usage: wifi-connect <ssid> password <password>
#alias wifi-add="sudo nmcli dev wifi connect"
#alias wifi-delete="nmcli con delete"

# screen brightness
#alias bright="sudo brightnessctl -d 'intel_backlight' -set"

# programming
alias dc="docker-compose"
alias denv="docker run --rm -it -v (pwd):/code"
