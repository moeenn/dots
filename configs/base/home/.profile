LC_CTYPE=en_US.UTF-8
XDG_DATA_HOME=${HOME}/.config
FLATPAKBIN=/var/lib/flatpak/exports/bin
NODEBIN=${HOME}/.npm/bin
GOPATH=${HOME}/.go
GOBIN=${GOPATH}/bin
GEM_HOME=${HOME}/.config/gem/ruby/3.0.0
RUBYBIN=${GEM_HOME}/bin
RUSTBIN=${HOME}/.cargo/bin

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
PATH=${PATH}:${FLATPAKBIN}:${PATH}:${HOME}/.bin:${HOME}/.local/bin
PATH=${PATH}:${NODEBIN}:${GOPATH}:${RUBYBIN}:${RUSTBIN}

export LC_CTYPE XDG_DATA_HOME PATH GOPATH GOBIN GEM_HOME
