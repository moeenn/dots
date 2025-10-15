DISPLAY=:0.0
LC_CTYPE=en_US.UTF-8
XDG_DATA_HOME=${HOME}/.config
XDG_DATA_DIRS=${XDG_DATA_DIRS}:${XDG_DATA_HOME}/flatpak/exports/share
FLATPAKBIN=/var/lib/flatpak/exports/bin
NODEBIN=${HOME}/.npm/bin
GOINSTALL=/usr/local/go/bin
GOBIN=${HOME}/go/bin
OPAMBIN=${HOME}/.opam/default/bin

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
PATH=${PATH}:${FLATPAKBIN}:${PATH}:${HOME}/.bin:${HOME}/.local/bin
PATH=${PATH}:${GOINSTALL}:${NODEBIN}:${GOINSTALL}:${GOBIN}:${OPAMBIN}

export DISPLAY LC_CTYPE XDG_DATA_HOME XDG_DATA_DIRS PATH
