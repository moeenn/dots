CC=cc
SRC := ./src/*.c
TARGET = cwmstatus
CFLAGS = -Wall -Wextra -std=c23
BIN_DIR = ~/.local/bin

main:
	 @${CC} ${SRC} -o ./bin/${TARGET}

clean:
	rm -f ./bin/*

install: main
	mv -v ./bin/${TARGET} ${BIN_DIR}/

uninstall:
	rm -vf ${BIN_DIR}/${TARGET}

.PHONY: clean install uninstall
