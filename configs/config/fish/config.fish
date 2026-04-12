## Set colorscheme :: fish_config
# suppress welcome message
set fish_greeting

# misc. adjustments.
set fish_cursor_default block

# disable right prompt
function fish_right_prompt
    #intentionally left blank
end

# link zoxide.
zoxide init fish | source

# --------------------------------------------------------------------
#
#   Environment and path config
#
# --------------------------------------------------------------------
set SYSPATH /bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin
set FLATPAK_PATH /var/lib/flatpak/exports/bin
set USER_PATH {$HOME}/.bin {$HOME}/.local/bin
set NODEBIN {$HOME}/.npm/bin
set BUNBIN {$HOME}/.bun/bin
set GOINSTALL {$HOME}/.local/go/bin
set GOBIN {$HOME}/go/bin
set CARGO_BIN {$HOME}/.cargo/bin
set -U fish_user_paths {$SYSPATH} {$FLATPAK_PATH} {$USER_PATH} {$NODEBIN} {$BUNBIN} {$GOINSTALL} {$GOBIN} {$CARGO_BIN}

# --------------------------------------------------------------------
#
#   Shell Aliases
#
# --------------------------------------------------------------------
# Operations
alias cd z
alias .. "z .."
alias cp "cp -v"
alias mv "mv -iv"
alias rs "rsync -av --progress"
alias rm "rm -iv"
alias link "ln -sr"
alias ls "ls -ap --color=never"
alias lsa "ls -alp"
alias :w which
alias :q exit
alias :Q exit
alias reload "source ~/.config/fish/config.fish"

# Programs
alias load "htop -u moeenn"
alias df "dfc -f -s"
alias uptime "uptime -p"
alias extract "dtrx -v"
alias net "bwm-ng -t 1000"
alias lsblk "lsblk -e 7"
alias clock "tty-clock -cD"
alias winclass "xprop WM_CLASS"
alias keyname "xev | grep keysym"

# Super User Tasks
alias full_access "sudo chmod -R a+rw ./"
alias mount "sudo mount -o rw"

# git
alias g git
alias :s "git status"
alias :S "git status"
alias :c "git commit -m"
alias :C "git commit -m"
alias :b "git branch"
alias :B "git branch"
alias :d "git diff"
alias push "git push"
alias pull "git pull"

# programming
alias dc "docker-compose"
alias py python3


