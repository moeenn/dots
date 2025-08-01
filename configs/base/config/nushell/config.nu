# update system path.
# $env.PATH = ($env.PATH | split row (char esep) | append "/var/lib/flatpak/exports/bin")
# $env.PATH = ($env.PATH | split row (char esep) | append "~/.bin")
# $env.PATH = ($env.PATH | split row (char esep) | append "~/.local/bin/")
# $env.PATH = ($env.PATH | split row (char esep) | append "~/.npm/bin")
# $env.PATH = ($env.PATH | split row (char esep) | append "/usr/local/go/bin")
# $env.PATH = ($env.PATH | split row (char esep) | append "~/go/bin")

# set required env variables.
$env.LS_COLORS = ""
$env.PROMPT_COMMAND_RIGHT = ""
$env.PROMPT_COMMAND = { $"(pwd | path basename)" }
$env.PROMPT_INDICATOR = "$ "

# disable ls colors.
$env.config = {
  show_banner: false
  buffer_editor: 'vim'
  use_ansi_coloring: true
  table: {
    mode: 'none'
  }
}

# set the theme.
source ./themes/gruvbox_light_hard.nu

# set common aliases.
alias .. = cd ..
alias cp = cp -v
alias mv = mv -iv
alias rsync = rsync -av
alias rm = rm -iv
alias link = ln -sr
alias ls = ls -a
alias lsa = ls -al
alias :q = exit
alias :Q = exit

# Programs
alias load = htop -u moeenn
alias df = dfc -f -s
alias net = bwm-ng -t 1000
alias lsblk = lsblk -e 7
alias clock = tty-clock -cD
alias m = mpv

# Super User Tasks
alias full_access = sudo chmod -R a+rw ./

# git
alias :s = git status
alias :S = git status
alias :c = git commit -m
alias :C = git commit -m
alias :b = git branch
alias :B = git branch
alias :d = git diff
alias push = git push
alias pull = git pull

# programming
alias dc = docker-compose
alias py = python3
alias pm = python3 -m
