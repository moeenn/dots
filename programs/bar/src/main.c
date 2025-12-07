#include "common.h"
#include <X11/X.h>
#include <X11/Xft/Xft.h>
#include <X11/Xlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

typedef enum
{
    TOP_LEFT,
    TOP_RIGHT,
    BOTTOM_LEFT,
    BOTTOM_RIGHT,
} position_e;

typedef struct
{
    int x;
    int y;
} coord_s;

static const size_t TIME_BUF_SIZE = 100;
static const char *TIME_FORMAT = "%b %d  -  %H:%M";
static const char *BAR_TITLE = "Bar";
static const char *FONT = "Roboto:size=12:antialias=true";
static const int BAR_HEIGHT = 50;
static const int BAR_WIDTH = 200;
static const unsigned int DISPLAY_PADDING = 10;
static const position_e POSITION = TOP_RIGHT;
static const char *BG_COLOR = "#000000";
static const char *FG_COLOR = "#ffffff";
static const int UPDATE_DELAY = 1; // seconds.

result_e getTime(char *buf)
{
    time_t cur_time = time(NULL);
    if (cur_time == ((time_t)-1))
    {
        return RESULT_ERR;
    }

    struct tm *tm;
    tm = localtime(&cur_time);
    strftime(buf, TIME_BUF_SIZE, TIME_FORMAT, tm);
    return RESULT_OK;
}

coord_s calculateBarCoordinates(Display *display, unsigned int screen)
{
    int x, y;
    int screenWidth = XDisplayWidth(display, screen);
    int screenHeight = XDisplayHeight(display, screen);

    switch (POSITION)
    {
    case TOP_LEFT:
        x = DISPLAY_PADDING;
        y = DISPLAY_PADDING;
        break;

    case TOP_RIGHT:
        x = screenWidth - DISPLAY_PADDING - BAR_WIDTH;
        y = DISPLAY_PADDING;
        break;

    case BOTTOM_LEFT:
        x = DISPLAY_PADDING;
        y = screenHeight - DISPLAY_PADDING - BAR_HEIGHT;
        break;

    case BOTTOM_RIGHT:
        x = screenWidth - DISPLAY_PADDING - BAR_WIDTH;
        y = screenHeight - DISPLAY_PADDING - BAR_HEIGHT;
        break;
    }

    return (coord_s){.x = x, .y = y};
}

int main()
{
    Display *display;
    XSetWindowAttributes attr;
    int screen;
    GC gc;
    Window rootWindow;
    Window window;
    XEvent event;
    Colormap cmap;
    XftDraw *xftDraw;
    XftFont *xftFont;
    XftColor xftColor;
    coord_s barCoord;
    XColor bgColor;

    display = XOpenDisplay(nullptr);
    if (display == nullptr)
    {
        fprintf(stderr, "error: failed to open display.\n");
        return 1;
    }

    screen = DefaultScreen(display);
    cmap = DefaultColormap(display, screen);
    rootWindow = RootWindow(display, screen);
    barCoord = calculateBarCoordinates(display, screen);

    XParseColor(display, cmap, BG_COLOR, &bgColor);
    XAllocColor(display, cmap, &bgColor);

    window =
        XCreateSimpleWindow(display, rootWindow, barCoord.x, barCoord.y, BAR_WIDTH, BAR_HEIGHT, 0, 0, bgColor.pixel);

    XStoreName(display, window, BAR_TITLE);
    gc = XCreateGC(display, window, 0, NULL);

    xftDraw = XftDrawCreate(display, window, DefaultVisual(display, screen), cmap);
    xftFont = XftFontOpenName(display, screen, FONT);
    if (xftFont == NULL)
    {
        fprintf(stderr, "error: failed to load font: %s.\n", FONT);
        return 1;
    }

    XftColorAllocName(display, DefaultVisual(display, screen), cmap, FG_COLOR, &xftColor);
    attr.override_redirect = True;
    XChangeWindowAttributes(display, window, CWOverrideRedirect, &attr);
    XSelectInput(display, window, Expose | ExposureMask | KeyPressMask);
    XMapWindow(display, window);

    char text[100];
    int fontY = BAR_HEIGHT - ((BAR_HEIGHT - xftFont->height) / 2) - 4;
    int fontX = ((BAR_WIDTH - xftFont->max_advance_width) / 4) + 4;
    char time_buf[TIME_BUF_SIZE];

    while (1)
    {
        if (XPending(display) > 0)
        {
            XNextEvent(display, &event);
            if (event.type == Expose)
            {
                XftDrawStringUtf8(xftDraw, &xftColor, xftFont, fontX, fontY, (const FcChar8 *)text, strlen(text));
            }
        }

        getTime(time_buf); // TODO: handle error.
        sprintf(text, "%s", time_buf);

        XClearWindow(display, window);
        XftDrawStringUtf8(xftDraw, &xftColor, xftFont, fontX, fontY, (const FcChar8 *)text, strlen(text));
        XFlush(display);
        sleep(UPDATE_DELAY);
    }

    XftFontClose(display, xftFont);
    XftDrawDestroy(xftDraw);
    XftColorFree(display, DefaultVisual(display, screen), cmap, &xftColor);
    XFreeGC(display, gc);
    XDestroyWindow(display, window);
    XCloseDisplay(display);

    return 0;
}
