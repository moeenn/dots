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
set GOINSTALL /usr/local/go/bin
set GOBIN {$HOME}/go/bin
set OPAMBIN {$HOME}/.opam/default/bin
set -U fish_user_paths {$SYSPATH} {$FLATPAK_PATH} {$USER_PATH} {$NODEBIN} {$GOINSTALL} {$GOBIN} {$OPAMBIN}

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
alias rsync "rsync -av"
alias rm "rm -iv"
alias link "ln -sr"
alias ls "ls -ap --color=always"
alias lsa "ls -alp"
alias :w which
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
alias full_access "sudo chmod -R a+rw ./"

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
alias dc docker-compose
alias py python3
alias pm "python3 -m"
alias delete_dstore "find . -name ".DS_Store" -type f -delete -print"
alias m mvn


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/moeenn/.opam/opam-init/init.fish' && source '/home/moeenn/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration
