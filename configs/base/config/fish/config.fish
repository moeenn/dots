## TO set a colorscheme: $ fish_config colors

# suppress welcome message
set fish_greeting


# --------------------------------------------------------------------
#
#   Environment and path config
#
# --------------------------------------------------------------------
set SYSPATH /bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin {$HOME}/.bin {$HOME}/.local/bin
set FLATPAK_PATH /var/lib/flatpak/exports/bin

set RUST_BACKTRACE 0
set GOPATH {$HOME}/.go
set GOBIN {$GOPATH}/bin
set DENO_INSTALL {$HOME}/.deno
set DENOBIN {$DENO_INSTALL}/bin

set RUSTBIN {$HOME}/.cargo/bin
set NODEBIN {$HOME}/.npm/bin
set PHPBIN {$HOME}/.config/composer/vendor/bin

set -U fish_user_paths {$SYSPATH} {$FLATPAK_PATH} {$HOME}/.bin {$HOME}/.local/bin {$GOBIN} {$RUSTBIN} {$NODEBIN} {$DENOBIN} {$PHPBIN}


# --------------------------------------------------------------------
#
#   Shell Aliases
#
# --------------------------------------------------------------------
# package management
alias pkg:update "sudo apt-get update"
alias pkg:search "apt-cache search"
alias pkg:install "sudo apt-get install -y"
alias pkg:remove "sudo apt-get remove"
alias pkg:upgrade "sudo apt-get upgrade -y"
alias pkg:purge_config "sudo dpkg --purge (dpkg --get-selections | grep deinstall | cut -f1 )"
alias pkg:autoremove "sudo apt-get autoremove && pkg:purge_config"
alias pkg:clean "sudo apt-get autoclean; sudo apt-get clean"

# Operations
alias .. "cd .."
alias cp "cp -v"
alias mv "mv -iv"
alias rsync "rsync -avP"
alias rm "rm -iv"
alias link "ln -sr"
alias ls "ls -ap --color=always"
alias lsa "ls -alp"
alias :q "exit"
alias :Q "exit"

# Programs
alias load "htop -u moeenn"
alias df "dfc -f -s"
alias uptime "uptime -p"
alias extract "dtrx -v"
alias net "bwm-ng -t 1000"
alias speed "speedtest-rs"
alias lsblk "lsblk -e 7"
alias c "codium ."
alias patch "patch -p1 < "
alias v "nvim"

# Super User Tasks
alias kill "killall -v --ignore-case"
alias full_access "sudo chmod -R a+rw ./"

# tmux
alias t "tmux"
alias att "tmux attach -t default"

# git
alias :s "git status"
alias :S "git status"
alias :c "git commit -m"
alias :C "git commit -m"
alias :b "git branch"
alias :B "git branch"
alias push "git push"

# wifi management
alias wifi-scan "nmcli dev wifi list"
alias wifi-list "nmcli con show"
alias wifi-on "nmcli radio wifi on"
alias wifi-off "nmcli radio wifi off"
alias wifi-disconnect "nmcli con down"
alias wifi-connect "sudo nmcli con up"

# usage: wifi-connect <ssid> password <password>
alias wifi-add "sudo nmcli dev wifi connect"
alias wifi-delete "nmcli con delete"

# screen brightness
alias bright "sudo brightnessctl -d 'intel_backlight' -set"

# programming
alias py "python3"
alias venv "python3 -m venv"
alias dc "docker-compose"
