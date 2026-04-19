NAME=battery-notify
CC=cc
CFLAGS=-Wall -Wextra -pedantic -Werror -O3
SRC=./src/main.c
TARGET=./bin/${NAME}
INSTALL_PATH=${HOME}/.local/bin

main:
	${CC} ${SRC} ${CFLAGS} ${LDDFLAGS} -o ${TARGET}

run: main
	@${TARGET}

install: main
	mv -fv ${TARGET} ${INSTALL_PATH}
