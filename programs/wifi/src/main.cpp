#include <cstdlib>
#include <cstring>
#include <iostream>
#include <sstream>

namespace wifi {
bool strEquals(const char* a, const char* b) { return std::strcmp(a, b) == 0; }
int execute(const std::string& cmd)
{
    return std::system(cmd.c_str());
}

std::string trim(const std::string& line)
{
    const char* WhiteSpace = " \t\v\r\n";
    std::size_t start = line.find_first_not_of(WhiteSpace);
    std::size_t end = line.find_last_not_of(WhiteSpace);
    return start == end ? std::string() : line.substr(start, end - start + 1);
}

int printHelp()
{
    const char* help = "usage: wifi [COMMAND] [PACKAGES] \n\n"
                       "commands: \n"
                       "  help        display this help message and exit.\n"
                       "  status      current network connection status.\n"
                       "  list        list devices and connection names.\n"
                       "  add         add a new wifi.\n"
                       "  connect     connect to an already added conncection.\n"
                       "  disconnect  disconnect wifi using interface name.\n"
                       "  delete      delete a wifi connection.\n";

    std::cout << help << "\n";
    return 0;
}

int getStatus()
{
    return execute("nmcli dev status");
}

int listConnections()
{
    return execute("nmcli con show");
}

int addConnection()
{
    std::string ssid;
    std::cout << "SSID: ";
    std::cin >> ssid;

    std::string password;
    std::cout << "Password: ";
    std::cin >> password;

    std::stringstream cmd;
    cmd << "nmcli device wifi connect " << trim(ssid) << " password " << trim(password);
    return execute(cmd.str());
}

int activateConnection(const char* connectionName)
{
    std::stringstream cmd;
    cmd << "nmcli con up " << connectionName;
    return execute(cmd.str());
}

int disconnectWifi(const char* interfaceName)
{
    std::stringstream cmd;
    cmd << "nmcli dev disconnect iface " << interfaceName;
    return execute(cmd.str());
}

int deleteConnection(const char* connectionName)
{
    std::stringstream cmd;
    cmd << "nmcli con del " << connectionName;
    return execute(cmd.str());
}

int processCommand(const char* command, int argc, char** argv)
{
    if (strEquals(command, "help")) {
        return printHelp();
    }

    if (strEquals(command, "status")) {
        return getStatus();
    }

    if (strEquals(command, "list")) {
        return listConnections();
    }

    if (strEquals(command, "add")) {
        return listConnections();
    }

    if (strEquals(command, "connect")) {
        if (argc < 3) {
            std::cerr << "error: please provide a wifi ssid to continue.\n";
            return 1;
        }

        if (argc > 3) {
            std::cerr << "error: please provide a single wifi ssid.\n";
            return 1;
        }

        const char* ssid = argv[2];
        return activateConnection(ssid);
    }

    std::cerr << "error: invalid command.";
    return 1;
}
}

int main(int argc, char** argv)
{
    if (argc < 2) {
        std::cerr << "error: please provide a command to continue.\n";
        return 1;
    }

    const char* command = argv[1];
    return wifi::processCommand(command, argc, argv);
}
