NAME=pkg
CC=cc
STD=c2x
CFLAGS=-Wall -Wextra -pedantic -Werror -O3
INSTALL_PREFIX=${HOME}/.local/bin
SRC=./src/main.c
TARGET=./bin/${NAME}

main:
	${CC} ${SRC} -std=${STD} ${CFLAGS} -o ${TARGET}

install: main
	mv -v ${TARGET} ${INSTALL_PREFIX}
