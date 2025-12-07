#include <stdio.h>

static const char* RESET = "\x1b[0m";
static const int LINES = 3;
static const char* TEXT = "     ";

int main()
{
    puts("");

    int i, c;
    for (i = 0; i < LINES; i++) {
        for (c = 40; c < 48; c++) {
            printf(" \x1b[1;%dm%s%s ", c, TEXT, RESET);
        }
        puts("");
    }

    puts("");
    return 0;
}
