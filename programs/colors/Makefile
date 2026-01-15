NAME=colors
CC=cc
STD=c99
CFLAGS=-Wall -Wextra -pedantic -Werror -O3
INC=
LDDFLAGS=
INSTALL_PREFIX=${HOME}/.local/bin

SRC=./src/main.c
TARGET=./bin/${NAME}

main:
	${CC} ${SRC} -std=${STD} ${INC} ${CFLAGS} ${LDDFLAGS} -o ${TARGET}

run: main
	@${TARGET}

install:
	@mv -v ${TARGET} ${INSTALL_PREFIX}
