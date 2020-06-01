# settings
set fish_greeting

# package management
abbr -a update 'sudo apt-get update'
abbr -a search 'apt-cache search'
abbr -a install 'sudo apt-get install -y'
abbr -a remove 'sudo apt-get remove'
abbr -a upgrade 'sudo apt-get upgrade -y'
abbr -a autoremove 'sudo apt-get autoremove'
abbr -a purge_configs 'sudo dpkg --purge (dpkg --get-selections | grep deinstall | cut -f1 )'

# abbr -a update 'sudo dnf update'
# abbr -a search 'dnf search'
# abbr -a install 'sudo dnf install -y'
# abbr -a remove 'sudo dnf remove'

# Operations
abbr -a .. 'cd ..'
abbr -a ... '.. && ..'
abbr -a cp 'cp -v'
abbr -a mv 'mv -iv'
abbr -a rsync 'rsync -avP'
abbr -a rm 'rm -iv'
abbr -a link 'ln -s -r'
abbr -a ls 'ls -p --color'
abbr -a lsa 'ls -lpa | column -t'
abbr -a :q 'exit'

# Programs
abbr -a load 'htop -u moeenn'
abbr -a bin 'cd ~/.bin/'
abbr -a df 'dfc -f -s'
abbr -a time 'tty-clock -cb -C 6'
abbr -a uptime 'uptime -p'
abbr -a get 'axel -n 4'
abbr -a extract 'dtrx -v'
abbr -a m 'mpv'
abbr -a net 'bwm-ng -t 1000'
abbr -a dtrx 'dtrx -v'
abbr -a lsblk 'lsblk -e 7'
abbr -a watch 'watch -ct -n 1 -d'

# Super User Tasks
abbr -a poweroff 'sudo poweroff'
abbr -a reboot 'sudo reboot'
abbr -a kill 'killall -v --ignore-case'
abbr -a full_access 'sudo chmod -R a+rw ./'

# Git
abbr -a push 'git push origin master'
abbr -a upstream 'git remote add upstream'
abbr -a pull 'git pull origin master --allow-unrelated-histories'
abbr -a :s 'git status'
abbr -a commit 'git commit -m'
abbr -a clone 'git clone'

# tmux
abbr -a att 'tmux attach -t default'

# programming
abbr -a py 'python3'
