#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

const size_t MAX_CMD_LEN = 1000;
const char* COLOR_RESET = "\033[0m";
const char* COLOR_BLACK = "\033[30m";
const char* COLOR_RED = "\033[31m";
const char* COLOR_BLUE = "\033[34m";

bool commandExists(char* cmd)
{
    size_t cmdSize = strlen(cmd);
	char fullCmd[20 + cmdSize];
	sprintf(fullCmd, "which %s > /dev/null", cmd);
	int result = system(fullCmd);
	return result == 0;
}

bool execute(char* cmd[], size_t size)
{
	size_t fullSize = size;
	for (size_t i = 0; i < size; i++) {
		fullSize += strlen(cmd[i]);
	}

	if (fullSize > MAX_CMD_LEN) {
    	// TODO: maybe heap allocate the full command buffer in this case.
		printf("%serror: the command exceeds the maximum command length of %zu characters.%s\n", COLOR_RED, MAX_CMD_LEN, COLOR_RESET);
		return false;
	}

	char fullCmd[fullSize];
	size_t cmdlen;
	size_t i = 0;
	for (size_t ci = 0; ci < size; ci++) {
		cmdlen = strlen(cmd[ci]);
		for (size_t si = 0; si < cmdlen; si++) {
			fullCmd[i++] = cmd[ci][si];
		}
		fullCmd[i++] = ' ';
	}
	fullCmd[fullSize-1] = '\0';	

	printf("%srunning: %s%s\n", COLOR_BLUE, fullCmd, COLOR_RESET);
	int result = system(fullCmd);
	return result == 0;
}

bool pkg_update()
{
    constexpr size_t SIZE = 4;
	char* cmd[SIZE] = {"sudo", "apt-get", "update", "-y"};
	return execute(cmd, SIZE);
}

bool pkg_upgrade() 
{
	constexpr size_t SIZE = 4;
	char* cmd[SIZE] = {"sudo", "apt-get", "upgrade", "-y"};
	return execute(cmd, SIZE);
}

bool pkg_distupgrade() 
{
	constexpr size_t SIZE = 4;
	char* cmd[SIZE] = {"sudo", "apt-get", "dist-upgrade", "-y"};
	return execute(cmd, SIZE);
}

bool pkg_search(char *pkg)
{
	constexpr size_t SIZE = 3;
	char* cmd[SIZE] = {"apt-cache", "search", pkg};
	return execute(cmd, SIZE);
}

bool pkg_install(char* pkgs[], size_t size)
{
	const size_t fullsize = 4 + size;
	char* cmd[fullsize];
	cmd[0] = "sudo";
	cmd[1] = "apt-get";
	cmd[2] = "install";
	cmd[3] = "-y";
	
	for (size_t i = 4; i < fullsize; i++) {
		cmd[i] = pkgs[i-4];
	}
	return execute(cmd, fullsize);
}

bool pkg_remove(char* pkgs[], size_t size)
{
    const size_t fullsize = 4 + size;
    char* cmd[fullsize];
    cmd[0] = "sudo";
    cmd[1] = "apt-get";
    cmd[2] = "remove";
    cmd[3] = "-y";

	for (size_t i = 4; i < fullsize; i++) {
		cmd[i] = pkgs[i-4];
	}
	return execute(cmd, fullsize);
}

bool pkg_clean() 
{
	constexpr size_t SIZE = 5;
	char* cmd[SIZE] = {"sudo", "apt-get", "autoremove", "--purge", "-y"};
	return execute(cmd, SIZE);
}

bool flatpak_exists()
{
    return commandExists("flatpak");
}

bool flatpak_update() 
{
	constexpr size_t SIZE = 4;
	char* cmd[SIZE] = {"sudo", "flatpak", "update", "-y"};
	return execute(cmd, SIZE);
}

bool flatpak_install(char* pkgs[], size_t size) 
{
	const size_t fullsize = 5 + size;
	char* cmd[fullsize];
	cmd[0] = "sudo";
	cmd[1] = "flatpak";
	cmd[2] = "install";
	cmd[3] = "flathub";
	cmd[4] = "-y";

	for (size_t i = 5; i < fullsize; i++) {
		cmd[i] = pkgs[i-5];
	}
	return execute(cmd, fullsize);
}

bool flatpak_remove(char* pkgs[], size_t size) 
{    
	const size_t fullsize = 4 + size;
	char* cmd[fullsize];
	cmd[0] = "sudo";
	cmd[1] = "flatpak";
	cmd[2] = "uninstall";
	cmd[3] = "--delete-data";

	for (size_t i = 4; i < fullsize; i++) {
		cmd[i] = pkgs[i-4];
	}
	return execute(cmd, fullsize);
}

bool flatpak_clean() 
{
 	constexpr size_t SIZE = 4;
 	char* cmd[SIZE] = {"sudo", "flatpak", "uninstall", "--unused"};
 	return execute(cmd, SIZE);
}

void printHelp()
{
	const char* msg = "usage: pkg [COMMAND] [PACKAGES]\n\n" 
	"commands:\n"
    "help             (h)   display this help message and exit.\n"
    "search           (s)   search for a single package.\n"
    "install          (i)   install new packages.\n"
    "flatpak-install  (fi)  install flatpak packages.\n"
    "update           (u)   update installed packages.\n"
    "remove           (r)   remove provided packages.\n"
    "flatpak-remove   (fr)  remove flatpak packages.\n"
    "clean            (c)   remove orphan packages.\n";

	puts(msg);
}

bool matchCommand(const char* full, const char* shrt, char* cmd)
{
	return strcmp(full, cmd) == 0 || strcmp(shrt, cmd) == 0;
}

void errorOut(const char* error) 
{
	fprintf(stderr, "%serror: %s.%s\n", COLOR_RED, error, COLOR_RESET);
}

int main(int argc, char* argv[])
{
	if (argc < 2) {
    	errorOut("please provide a command to continue");    	
		return 1;
	}

	char* cmd = argv[1];
	if (matchCommand("help", "h", cmd)) {
		printHelp();
		return 0;
	}

	if (matchCommand("update", "u", cmd)) {
		if (!pkg_update()) {
			errorOut("failed to update packages");
			return 1;
		}
		if (!pkg_upgrade()) {
			errorOut("failed to upgrade system");
			return 1;
		}
		if (!pkg_distupgrade()) {
			errorOut("failed to perform distribution upgrade");
			return 1;
		}
		
		return 0;
	}

	if (matchCommand("clean", "c", cmd)) {
		if (!pkg_clean()) {
			errorOut("failed to clean system packages");
			return 1;
		}

		if (flatpak_exists()) {
			if (!flatpak_clean()) {
				errorOut("failed to clean flatpak packages");
				return 1;
			}
		}

		return 0;
	}

	if (matchCommand("search", "s", cmd)) {
		if (argc < 3) {
			errorOut("please provide a package name to search");
			return 1;
		}
		if (argc > 3) {
			errorOut("can only search for one package at a time");
			return 1;
		}

		char* pkg = argv[2];
		if (!pkg_search(pkg)) {
			errorOut("failed to search for package");
			return 1;
		}

		return 0;
	}
	
	size_t numPkgs = argc - 2;

	if (matchCommand("install", "i", cmd)) {
		if (numPkgs < 1) {
			errorOut("please provide at-least one package to install");
			return 1;
		}

		char* pkgs[numPkgs];
		for (size_t i = 2; i < (size_t) argc; i++) {
			pkgs[i-2] = argv[i];
		}

		if (!pkg_install(pkgs, numPkgs)) {
			errorOut("failed to install packages");
			return 1;
		}

		return 0;
	}

	if (matchCommand("flatpak-install", "fi", cmd)) {
		if (numPkgs < 1) {
			errorOut("please provide at-least one flatpak package to install");
			return 1;
		}

		if (!flatpak_exists()) {
			errorOut("flatpak support not found on this system");
			return 1;
		}

		char* pkgs[numPkgs];
		for (size_t i = 2; i < (size_t) argc; i++) {
			pkgs[i-2] = argv[i];
		}

		if (!flatpak_install(pkgs, numPkgs)) {
			errorOut("failed to install flatpak packages");
			return 1;
		}

		return 0;
	}

	if (matchCommand("remove", "r", cmd)) {
		if (numPkgs < 1) {
			errorOut("please provide at-least one package to remove");
			return 1;
		}

		char* pkgs[numPkgs];
		for (size_t i = 2; i < (size_t) argc; i++) {
			pkgs[i-2] = argv[i];
		}

		if (!pkg_remove(pkgs, numPkgs)) {
			errorOut("failed to remove packages");
			return 1;
		}

		return 0;
	}

	if (matchCommand("flatpak-remove", "fr", cmd)) {
		if (numPkgs < 1) {
			errorOut("please provide at-least one flatpak package to remove");
			return 1;
		}

		if (!flatpak_exists()) {
			errorOut("flatpak support not found on this system");
			return 1;
		}

		char* pkgs[numPkgs];
		for (size_t i = 2; i < (size_t) argc; i++) {
			pkgs[i-2] = argv[i];
		}

		if (!flatpak_remove(pkgs, numPkgs)) {
			errorOut("failed to remove flatpak packages");
			return 1;
		}

		return 0;
	}

	errorOut("unsupported command provided");
    return 1;
}

