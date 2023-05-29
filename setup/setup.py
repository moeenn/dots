import subprocess
import os
from config.config import load_config
from config.structures import FlatpakConfig
from log.log import log, Level


def install_apt_packages(packages: list[str]) -> None:
    """
        install apt packages listing in config the file
    """
    log("updating apt mirrors")
    subprocess.run(["sudo", "apt-get", "update", "-y"])

    log("installing apt packages")
    command = ["sudo", "apt-get", "install", "-y"] + packages
    subprocess.run(command)


def install_python_packages(packages: list[str]) -> None:
    """
        install python packages listing in the config file
    """
    log("installing python packages")
    command = ["pip3", "install"] + packages
    subprocess.run(command)


def install_flatpak_packages(config: FlatpakConfig) -> None:
    """
        install flatpak packages listed in config file
    """
    log("installing flatpak support")
    subprocess.run(["sudo", "apt-get", "install", "-y", "flatpak"])

    log("adding flathub mirror")
    subprocess.run(["sudo", "flatpak", "remote-add",
                   "--if-not-exists", "flathub", config.remote_url])

    log("installing essential flatpaks")
    subprocess.run(["sudo", "flatpak", "install",
                   "flathub", "-y"] + config.packages)


def configure_docker() -> None:
    """
        install and configure docker for the current user
    """
    log("adding docker support")
    subprocess.run(["sudo", "apt-get", "install", "-y", "docker"])

    user: str | None = os.getenv("USER")
    if not user:
        raise Exception("failed to get $USER from env")

    log("creating docker group")
    subprocess.run(["sudo", "groupadd", "docker"])

    log(f"adding current user ({user}) to docker group")
    subprocess.run(["sudo", "usermod", "-aG", "docker", user])


def main() -> None:
    """
        main program logic sequence
    """
    config = load_config()
    install_apt_packages(config.apt.packages)
    install_python_packages(config.python.packages)
    install_flatpak_packages(config.flatpak)
    configure_docker()


"""
    TODO:
    - [ ] Generate SSH key
    - [ ] Install helix editor
    - [ ] Link dots to home folders
"""

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt as err:
        log("ctrl+c: stopping...", level=Level.ERROR)
    except Exception as err:
        log("an errror has occured", level=Level.ERROR)
        print(err)
