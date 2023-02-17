import subprocess
from modules import entrypoint, Config, FlatpakManager, AptManager, DockerManager, link_files, home, configs_dir

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
    perform docker general configuration
"""


def configure_docker() -> None:
    dockerManager = DockerManager()
    dockerManager.create_docker_group()
    dockerManager.add_user_to_docker_group()


"""
    link all base configurations from this repo to the user home directory
"""


def link_configs() -> None:
    home_configs_dir = configs_dir() + "/base/home"
    link_files(home_configs_dir, home())

    xdg_configs_dir = configs_dir() + "/base/config"
    link_files(xdg_configs_dir, home() + "/.config")


"""
    links openbox related configurations to the system 
"""


def link_openbox_configs() -> None:
    openbox_config_dir: str = configs_dir() + "/openbox"
    link_files(openbox_config_dir, home() + "/.config")
    subprocess.run(["chmod", "+x", home() + "/.config/openbox/autostart"])    


"""
    the execution of the program will begin from this function
    the @entrypoint decorator adds error handling to this function
"""


@entrypoint
def main() -> None:
    # config = Config()
    # install_apt_packages(config)
    # install_flatpak(config)
    # configure_docker()
    # link_configs()
    link_openbox_configs()


if __name__ == "__main__":
    main()
