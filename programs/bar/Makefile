NAME=bar
CC=cc
STD=c23
CFLAGS=-Wall -Wextra -pedantic -Werror -O3
INC=-I./include -I/usr/include/freetype2
LDDFLAGS=-lm -lX11 -lXft

SRC=./src/main.c
TARGET=./bin/${NAME}

main:
	${CC} ${SRC} -std=${STD} ${INC} ${CFLAGS} ${LDDFLAGS} -o ${TARGET}

run: main
	@${TARGET}
