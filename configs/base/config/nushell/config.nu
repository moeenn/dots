$env.config.buffer_editor = "hx"
$env.config.show_banner = false
$env.PROMPT_COMMAND_RIGHT = ""

# Operations
alias cp = cp -v
alias mv = mv -iv
alias rsync = rsync -avP
alias rm = rm -iv
alias link = ln -sr
alias :q = exit
alias :Q = exit

# Programs
alias load = htop -u $env.USER
alias df = dfc -f -s
alias uptime = uptime -p
alias extract = dtrx -v
alias net = bwm-ng -t 1000
alias lsblk = lsblk -e 7
alias clock = tty-clock -cD
alias mpv = mpv
alias aria = aria2c -j 4 -s 4

# Super User Tasks
alias kill = killall -v --ignore-case
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
alias pm = python -m
alias t = tmux
