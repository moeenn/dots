#include <cstdlib>
#include <cstring>
#include <iostream>
#include <sstream>
#include <vector>

namespace pkg {
bool strEquals(const char* a, const char* b) { return std::strcmp(a, b) == 0; }
int execute(const std::string& cmd)
{
    return std::system(cmd.c_str());
}

int printHelp()
{
    const char* help = "usage: pkg [COMMAND] [PACKAGES] \n\n"
                       "commands: \n"
                       "  help    (h)    display this help message and exit.\n"
                       "  search  (s)    search for packages.\n"
                       "  install (i)    install new packages.\n"
                       "  update  (u)    fetch and install package updates.\n"
                       "  remove  (r)    remove packages.\n"
                       "  clean   (c)    remove orphan packages.\n";

    std::cout << help << "\n";
    return 0;
}

class DebianPackageManager {
public:
    [[nodiscard]]
    int search(const std::string& package) const
    {
        std::stringstream cmd;
        cmd << "apt-cache search " << package;
        return execute(cmd.str());
    }

    [[nodiscard]]
    int install(const std::vector<std::string>& packages) const
    {
        std::stringstream cmd;
        cmd << "sudo apt-get install -y ";
        for (const auto& pkg : packages) {
            cmd << pkg << " ";
        }

        return execute(cmd.str());
    }

    [[nodiscard]]
    int update() const
    {
        int code = execute("sudo apt-get update");
        if (code != 0) {
            return code;
        }

        return execute("sudo apt-get upgrade -y");
    }

    [[nodiscard]]
    int clean() const
    {
        return execute("sudo apt-get autoremove --purge");
    }

    [[nodiscard]]
    int remove(const std::vector<std::string>& packages) const
    {
        std::stringstream cmd;
        cmd << "sudo apt-get remove -y ";
        for (const auto& pkg : packages) {
            cmd << pkg << " ";
        }

        return execute(cmd.str());
    }
};
}

int main(int argc, char** argv)
{
    if (argc < 2) {
        std::cerr << "error: please provide a command to continue.\n";
        return 1;
    }

    const char* command = argv[1];
    const pkg::DebianPackageManager pm {};

    if (pkg::strEquals(command, "help") || pkg::strEquals(command, "h")) {
        return pkg::printHelp();
    }

    if (pkg::strEquals(command, "search") || pkg::strEquals(command, "s")) {
        if (argc < 3) {
            std::cerr << "error: please provide a package name to search.\n";
            return 1;
        }

        if (argc > 3) {
            std::cerr << "error: can only search for one package at a time.\n";
            return 1;
        }

        const char* package = argv[2];
        return pm.search(package);
    }

    if (pkg::strEquals(command, "install") || pkg::strEquals(command, "i")) {
        if (argc < 3) {
            std::cerr << "error: please provide a package name to install.\n";
            return 1;
        }

        std::vector<std::string> packages {};
        for (int i = 2; i < argc; i++) {
            packages.push_back(argv[i]);
        }
        return pm.install(packages);
    }

    if (pkg::strEquals(command, "update") || pkg::strEquals(command, "u")) {
        return pm.update();
    }

    if (pkg::strEquals(command, "clean") || pkg::strEquals(command, "c")) {
        return pm.clean();
    }

    if (pkg::strEquals(command, "remove") || pkg::strEquals(command, "r")) {
        if (argc < 3) {
            std::cerr << "error: please provide at least one package to remove.\n";
            return 1;
        }

        std::vector<std::string> packages {};
        for (int i = 2; i < argc; i++) {
            packages.push_back(argv[i]);
        }
        return pm.remove(packages);
    }

    std::cerr << "error: invalid command.\n";
    return 1;
}
