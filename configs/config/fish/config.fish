# environment variables
set -x GOPATH "$HOME/.go"
set -x XDG_DATA_HOME "$HOME/.config"
set -x EDITOR "nano"
set -x CGO_ENABLED 1
set -x GO_SESSION_KEY 9a4772a776c6de8f446c2125b21346a601507333140c5e48c0c99210bbc3b247

# fedora package management
abbr -a update 'sudo dnf update --refresh'
abbr -a search 'sudo dnf search'
abbr -a install 'sudo dnf install -y'
abbr -a remove 'sudo dnf remove'

# Operations
abbr -a c 'clear'
abbr -a cp 'rsync --info progress2 -r'
abbr -a mv 'mv -ivf'
abbr -a rm 'rm -iv'
abbr -a link 'ln -s -r'
abbr -a :q 'exit'
abbr -a dir 'tree -d'

# Programs
abbr -a load 'htop -u moeen'
abbr -a df 'dfc -f -s'
abbr -a uptime 'uptime -p'
abbr -a get 'axel -n 4'
abbr -a extract 'dtrx -v'
abbr -a m 'mpv'
abbr -a cf 'cfiles'
abbr -a ydl 'youtube-dl --external-downloader axel'
abbr -a net 'bwm-ng -t 1000'

# Super User Tasks
abbr -a poweroff 'sudo poweroff'
abbr -a reboot 'sudo reboot'
abbr -a kill 'killall -v --ignore-case'
abbr -a full_access 'sudo chmod -R a+rw'

# Git
# Before you can use this command you need to do: git remote add upstream git+ssh://git@github.com/moeenn/repo
abbr -a upstream 'git remote add upstream'
abbr -a status 'git status'
abbr -a pull 'git pull origin master --allow-unrelated-histories'
abbr -a commit 'git commit -m "bugfixes"'
abbr -a push 'git push origin master'
abbr -a clone 'git clone'

# programming
abbr -a py 'python3'
#abbr -a test 'pytest -v'
#abbr -a test_all 'py.test -v'
