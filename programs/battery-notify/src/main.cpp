#include <cstdio>
#include <cstdlib>
#include <unistd.h>

const int LOW_PERC = 20;
const int SLEEP_DELAY_SEC = 60 * 5; // 5 minutes.

int getBatteryPerc() {
  FILE *fp = fopen("/sys/class/power_supply/BAT0/capacity", "r");
  if (fp == NULL) {
    return -1;
  }

  int percentage;
  if (fscanf(fp, "%d", &percentage) != 1) {
    fclose(fp);
    return 0;
  }

  fclose(fp);
  return percentage;
}

int sendNotification(int perc) {
  char cmd[300];
  sprintf(cmd, "notify-send --urgency=CRITICAL 'Battery Low: %d%%'", perc);
  return system(cmd);
}

int main() {
  int perc, result;

  while (true) {
    perc = getBatteryPerc();
    if (perc == 0) {
      fprintf(stderr, "error: failed to read battery details.\n");
      return 1;
    }

    if (perc <= LOW_PERC) {
      result = sendNotification(perc);
      if (result != 0) {
        fprintf(stderr, "error: failed to send notification.\n");
      }
    }

    sleep(SLEEP_DELAY_SEC);
  }
}
