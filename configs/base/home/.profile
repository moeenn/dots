LC_CTYPE=en_US.UTF-8
XDG_DATA_HOME=${HOME}/.config
NODEBIN=${HOME}/.npm/bin
SCALABIN=${HOME}/.config/coursier/bin
FLATPAKBIN=/var/lib/flatpak/exports/bin

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
PATH=${PATH}:${FLATPAKBIN}
PATH=${PATH}:${HOME}/.bin:${HOME}/.local/bin
PATH=${PATH}:${RUSTBIN}:${NODEBIN}:${SCALABIN}

export LC_CTYPE XDG_DATA_HOME RUST_BACKTRACE PATH

