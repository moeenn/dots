## Set colorscheme :: fish_config
# suppress welcome message
set fish_greeting

# disable right prompt
function fish_right_prompt
    #intentionally left blank
end

# --------------------------------------------------------------------
#
#   Environment and path config
#
# --------------------------------------------------------------------
set SYSPATH /bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin
set FLATPAK_PATH /var/lib/flatpak/exports/bin
set USER_PATH {$HOME}/.bin {$HOME}/.local/bin
set NODEBIN {$HOME}/.npm/bin
set GOINSTALL /usr/local/go/bin
set GOBIN {$HOME}/go/bin
set RUST_BIN {$HOME}/.cargo/bin
set -U fish_user_paths {$SYSPATH} {$FLATPAK_PATH} {$USER_PATH} {$NODEBIN} {$GOINSTALL} {$GOBIN} {$RUST_BIN}

# --------------------------------------------------------------------
#
#   Shell Aliases
#
# --------------------------------------------------------------------
# Operations
alias .. "cd .."
alias cp "cp -v"
alias mv "mv -iv"
alias rsync "rsync -avP"
alias rm "rm -iv"
alias link "ln -sr"
alias ls "ls -ap --color=always"
alias lsa "ls -alp"
alias :q exit
alias :Q exit

# Programs
alias load "htop -u moeenn"
alias df "dfc -f -s"
alias uptime "uptime -p"
alias extract "dtrx -v"
alias net "bwm-ng -t 1000"
alias lsblk "lsblk -e 7"
alias patch "patch -p1 <"
alias clock "tty-clock -cD"

# Super User Tasks
alias kill "killall -v --ignore-case"
alias full_access "sudo chmod -R a+rw ./"

# git
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
alias dc docker-compose
alias py python
alias pm "python -m"
alias delete_dstore "find . -name ".DS_Store" -type f -delete -print"
alias t tmux
alias cfmt "find . -iname '*.hpp' -o -iname '*.cpp' | xargs clang-format --style='Microsoft' -i"
