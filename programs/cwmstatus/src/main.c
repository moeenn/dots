#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

/**
 * program config.
 *
 */
static const size_t TIME_BUF_SIZE = 100;
static const char* TIME_FORMAT = "%d %B  -  %H:%M";
static const size_t WIFI_BUF_SIZE = 200;
static const char* SEPA = "   -   ";
static const int SLEEP_DELAY = 10;

typedef enum {
    RESULT_OK,
    RESULT_ERR,
} result_e;

[[nodiscard]] result_e get_time(char* buf)
{
    time_t cur_time = time(NULL);
    if (cur_time == ((time_t)-1)) {
        return RESULT_ERR;
    }

    struct tm* tm;
    tm = localtime(&cur_time);
    strftime(buf, TIME_BUF_SIZE, TIME_FORMAT, tm);
    return RESULT_OK;
}

[[nodiscard]] result_e get_wifi_name(char* buf)
{
    FILE* fp;

    fp = popen("iwgetid -r", "r");
    if (fp == NULL) {
        return RESULT_ERR;
    }

    // Read the output of the command
    if (fgets(buf, WIFI_BUF_SIZE, fp) != NULL) {
        buf[strcspn(buf, "\n")] = 0;
    } else {
        return RESULT_ERR;
    }

    pclose(fp);
    return RESULT_OK;
}

int main()
{
    char time_buf[TIME_BUF_SIZE];
    result_e time_r;

    char wifi_buf[TIME_BUF_SIZE];
    result_e wifi_r;

    for (;;) {
        if ((time_r = get_time(time_buf)) == RESULT_ERR) {
            fprintf(stderr, "error: failed to get the current time.\n");
            return RESULT_ERR;
        }

        if ((wifi_r = get_wifi_name(wifi_buf)) == RESULT_ERR) {
            fprintf(stderr, "error: failed to get the wifi name.\n");
            return RESULT_ERR;
        }

        fprintf(stdout, "%s%s%s\n", wifi_buf, SEPA, time_buf);
        fflush(stdout);
        sleep(SLEEP_DELAY);
    }

    return 0;
}
