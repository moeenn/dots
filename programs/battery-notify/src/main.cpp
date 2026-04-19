#include <cstdio>
#include <cstring>
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

int getBatteryStatus(char* status) {
	FILE *fp = fopen("/sys/class/power_supply/BAT0/status", "r");
	if (fp == NULL) {
		return -1;
	}

	if (fscanf(fp, "%s", status) != 1) {
		fclose(fp);
		return 0;
	}

	fclose(fp);
	return 0;
}

int sendNotification(int perc) {
  char cmd[300];
  sprintf(cmd, "notify-send --urgency=CRITICAL 'Battery Low: %d%%'", perc);
  return system(cmd);
}

int main() {
	char status[20];
	int perc, statusR, result;

  while (true) {
	statusR = getBatteryStatus(status);
	if (statusR == -1) {
		fprintf(stderr, "error: failed to read battery status.\n");
	}

	if (statusR == 0 && strcmp(status, "Charging") != 0) {
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
	} 

    sleep(SLEEP_DELAY_SEC);
  }
}
