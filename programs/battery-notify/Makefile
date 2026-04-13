NAME=battery-notify
CC=g++
CFLAGS=-Wall -Wextra -pedantic -Werror -O3
SRC=./src/main.cpp
TARGET=./bin/${NAME}
INSTALL_PATH=${HOME}/.local/bin

main:
	${CC} ${SRC} ${CFLAGS} ${LDDFLAGS} -o ${TARGET}

run: main
	@${TARGET}

install: main
	mv -fv ${TARGET} ${INSTALL_PATH}
