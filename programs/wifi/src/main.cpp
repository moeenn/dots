#include <iostream>
#include <cstdlib>
#include <cstring>

enum class Result : int
{
	ok = 0,
	err = 1,
};

[[nodiscard]] Result exec(const char *cmd)
{
	int status = std::system(cmd);
	if (status != 0) {
		return Result::err;
	}

	return Result::ok;
}

void prompt(char* buf, const char* message)
{
	std::cout << message;
	std::scanf("%s", buf);
}

bool argMatch(const char *arg, const char *full, const char *abbr)
{
	return std::strcmp(arg, full) == 0 || std::strcmp(arg, abbr) == 0;
}

[[nodiscard]] bool cmdIsInstalled()
{
    const char* cmd = "which nmcli > /dev/null";
    Result r = exec(cmd);
    return r == Result::ok;
}

void printHelp()
{
	const char* help = R"(usage: wifi [COMMAND] [PACKAGES]

commands:
  help     (h)   display this help message and exit.
  status   (s)   current network connection status.
  list     (l)   list devices and connection names.
  add      (a)   add a new wifi.
  connect  (c)   connect to an already added conncection.
  delete   (d)   delete a wifi connection.

)";

	std::cout << help;
}

[[nodiscard]] Result wifiGetStatus()
{
	const char *cmd = "nmcli dev status";
	return exec(cmd);
}

[[nodiscard]] Result wifiList()
{
	const char* cmd = "nmcli con show";
	return exec(cmd);
}

[[nodiscard]] Result wifiAdd(const char *ssid, const char *password)
{
	std::string cmd = std::format("nmcli dev wifi connect {} password {}", ssid, password);
	return exec(cmd.c_str());
}

int main(int argc, char** argv)
{
	if (argc < 2) 
    {
		std::cerr << "error: please provide a command to continue.\n";
		return 1;
    }

    bool isInstalled = cmdIsInstalled();
    if (!isInstalled)
    {
        std::cerr << "error: nmcli command is not found on the system.\n";
        return 1;
    }

	Result result = Result::ok;
    const char* cmd = argv[1];

	if (argMatch(cmd, "help", "h")) 
	{
    	printHelp();
    	result = Result::ok;
	}
	else if (argMatch(cmd, "status", "s")) 
	{
    	result = wifiGetStatus();
	}
	else if (argMatch(cmd, "list", "l"))
	{
    	result = wifiList();
	}
	else if (argMatch(cmd, "add", "a")) 
	{
    	char ssidBuf[100];
    	prompt(ssidBuf, "Wifi name: ");
    	char passwordBuf[100];
    	prompt(passwordBuf, "Password: ");
		result = wifiAdd(ssidBuf, passwordBuf);
	}
	else if (argMatch(cmd, "connect", "c"))
	{
    	// TODO: complete.
    	// nmcli conn up <ssid> 
    	result = wifiConnect();
	}
	else if (argMatch(cmd, "delete", "d")) 
	{
		// TODO: complete.
		// nmcli conn del <ssid>
		result = wifiDelete();
	}
	else {
		std::cerr << "error: invalid command provided.\n";
		return 1;
	}

	if (result == Result::err)
	{
    	std::cerr << "error: command failed.\n";
    	return 1;
	}

	return 0;	
}
