#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <X11/Xlib.h>

static Display *dpy;


void setstatus(char *str) {
	XStoreName(dpy, DefaultRootWindow(dpy), str);
	XSync(dpy, False);
}

int getdatetime(char *status, size_t size) {
	time_t result;
	struct tm *resulttm;

	result = time(NULL);
	resulttm = localtime(&result);

    return strftime(status, size, " %A - %H.%M ", resulttm);

}

int main(void) {
	char status[100];
    int l = 0;

	if (!(dpy = XOpenDisplay(NULL))) {
		fprintf(stderr, "Cannot open display.\n");
		return 1;
	}

	for (;;sleep(10)) {
        l = getdatetime(status, sizeof(status) - l);
		setstatus(status);
	}

	free(status);
	XCloseDisplay(dpy);

	return 0;
}

