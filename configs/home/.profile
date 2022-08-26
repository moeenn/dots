LC_CTYPE=en_US.UTF-8
XDG_DATA_HOME=${HOME}/.config
RUST_BACKTRACE=0
GOPATH=${HOME}/.go

GOBIN=${GOPATH}/bin
RUSTBIN=${HOME}/.cargo/bin
NODEBIN=${HOME}/.npm/bin
DENOBIN=${HOME}/.deno/bin
PHPBIN=${HOME}/.config/composer/vendor/bin

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
PATH=${PATH}:${HOME}/.bin:${HOME}/.local/bin
PATH=${PATH}:${GOBIN}:${RUSTBIN}:${NODEBIN}:${DENOBIN}:${PHPBIN}

export LC_CTYPE XDG_DATA_HOME RUST_BACKTRACE GOPATH PATH
. "$HOME/.cargo/env"
