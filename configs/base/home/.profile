LC_CTYPE=en_US.UTF-8
XDG_DATA_HOME=${HOME}/.config
FLATPAKBIN=/var/lib/flatpak/exports/bin
NODEBIN=${HOME}/.npm/bin
GOPATH=${HOME}/.go
GOBIN=${GOPATH}/bin
RUSTBIN=${HOME}/.cargo/bin
SCALABIN=${HOME}/.config/coursier/bin

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
PATH=${PATH}:${FLATPAKBIN}:${PATH}:${HOME}/.bin:${HOME}/.local/bin
PATH=${PATH}:${NODEBIN}:${GOBIN}:${RUSTBIN}:${SCALABIN}

export LC_CTYPE XDG_DATA_HOME PATH GOPATH 
