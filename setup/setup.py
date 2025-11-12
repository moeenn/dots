#! /bin/python3

import sys
import os
import tomllib
import subprocess
from dataclasses import dataclass 


COLOR_RED = "\x1b[31m"
COLOR_BLUE = "\x1b[34m"
COLOR_RESET = "\x1b[0m"


def exit(message: str, status=1) -> None:
    if status == 1:
        print(f"\n{COLOR_RED}error: {message}.{COLOR_RESET}")
    else:
        print(f"\n{message}.\n")        
    
    sys.exit(status)


def confirm(msg: str) -> bool:
    raw_input = input(f"\n{COLOR_BLUE}{msg} (Y/n/q): {COLOR_RESET}")
    if raw_input == "Q" or raw_input == "q":
        exit("exiting...", status=0)

    return raw_input == "Y" or raw_input == "y"


def update_repos() -> None:
    cmd = ["sudo", "apt-get", "update", "-y"]
    subprocess.run(cmd)


def install_packages(pkgs: list[str]) -> None:
    cmd = ["sudo", "apt-get", "install", "-y"] + pkgs
    subprocess.run(cmd)


def install_flatpaks(pkgs: list[str]) -> None:
    setup_cmd = ["flatpak", "remote-add", "--if-not-exists", "flathub", "https://dl.flathub.org/repo/flathub.flatpakrepo"]
    subprocess.run(setup_cmd)
    cmd = ["sudo", "flatpak", "install", "flathub", "-y"] + pkgs
    subprocess.run(cmd)


def get_username() -> str:
    username = os.environ.get("USER")
    if username is None or username == "":
        raise Exception("failed to identify current user")

    return username


def setup_docker(pkgs: list[str]) -> None:
    install_packages(pkgs)
    subprocess.run(["sudo", "groupadd", "docker"])
    subprocess.run(["sudo", "usermod", "-aG", "docker", get_username()])


def whereis_fish() -> str:
    output = subprocess.run(["which", "fish"], capture_output=True)
    return output.stdout.decode("utf-8").strip()


def setup_fish() -> None:
    subprocess.run(["sudo", "apt-get", "install", "-y", "fish"])
    user = get_username()
    fish_location = whereis_fish()
    subprocess.run(["sudo", "usermod", "-s", fish_location, user])


def setup_python(pkgs: list[str], pip_pkgs: list[str]) -> None:
    subprocess.run(["sudo", "apt-get", "install", "-y"] + pkgs)
    subprocess.run(["pipx", "install"] + pip_pkgs)


@dataclass
class ConfigPackages:
    base: list[str]
    flatpak: list[str]
    cpp: list[str]
    python: list[str]
    pip: list[str]
    java: list[str]
    docker: list[str]
    cwm: list[str]

@dataclass
class Config:
    packages: ConfigPackages

    @staticmethod
    def parse():
        with open("config.toml", "rb") as f:
            root_config = tomllib.load(f)
            return Config(
                packages=ConfigPackages(**root_config["packages"])
            )


def main() -> None:
    config = Config.parse()
    steps = {
        "Update repo lists?": lambda: update_repos(),
        "Install base packages?": lambda: install_packages(config.packages.base),
        "Install flatpaks?": lambda: install_flatpaks(config.packages.flatpak),
        "Install fish shell?": lambda: setup_fish(),
        "Install and configure docker?": lambda: setup_docker(config.packages.docker),
        "Install cwm?": lambda: install_packages(config.packages.cwm),
        "Configure python?": lambda: setup_python(config.packages.python, config.packages.pip),
        "Setup C++?": lambda: install_packages(config.packages.cpp),
        "Install java?": lambda: install_packages(config.packages.java),
    }

    for step_name, action in steps.items():
        if confirm(step_name):
            action()

    exit("Setup complete", status=0)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        exit("ctrl+c: exiting...", status=0)
    except Exception as ex:
        exit(str(ex))