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


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/moeenn/.opam/opam-init/init.sh' && . '/home/moeenn/.opam/opam-init/init.sh' > /dev/null 2> /dev/null || true
# END opam configuration
