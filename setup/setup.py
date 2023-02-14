from modules import entrypoint, Config, FlatpakManager, AptManager

"""
    update apt repos and install all packages listed in the config file
"""


def install_apt_packages(config: Config) -> None:
    packages = config.get_apt_config()
    aptManager = AptManager()
    aptManager.install_packages(packages)


"""
    flatpak package management will be configured on the system and all 
    flatpak packages listed in the config.json file will be installed
"""


def install_flatpak(config: Config) -> None:
    flatpak_config = config.get_flatpak_config()

    flatpakManager = FlatpakManager(flatpak_config.remote_url)
    flatpakManager.install_packages(flatpak_config.packages)


"""
    the execution of the program will begin from this function
    the @entrypoint decorator adds error handling to this function
"""


@entrypoint
def main() -> None:
    config = Config()
    install_apt_packages(config)
    install_flatpak(config)


if __name__ == "__main__":
    main()
