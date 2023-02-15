LC_CTYPE=en_US.UTF-8
XDG_DATA_HOME=${HOME}/.config
RUST_BACKTRACE=0
GOPATH=${HOME}/.go
DENO_INSTALL=${HOME}/.deno
DENOPATH=${DENO_INSTALL}/bin

GOBIN=${GOPATH}/bin
RUSTBIN=${HOME}/.cargo/bin
NODEBIN=${HOME}/.npm/bin
PHPBIN=${HOME}/.config/composer/vendor/bin
FLATPAKBIN=/var/lib/flatpak/exports/bin

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
PATH=${PATH}:${FLATPAKBIN}
PATH=${PATH}:${HOME}/.bin:${HOME}/.local/bin
PATH=${PATH}:${GOBIN}:${RUSTBIN}:${NODEBIN}:${DENOPATH}:${PHPBIN}

export LC_CTYPE XDG_DATA_HOME RUST_BACKTRACE GOPATH DENO_INSTALL PATH
