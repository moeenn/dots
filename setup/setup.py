#! /bin/python3

import sys
import tomllib
import subprocess
from dataclasses import dataclass 


COLOR_RED = "\x1b[31m"
COLOR_BLUE = "\x1b[34m"
COLOR_RESET = "\x1b[0m"


def exit(message: str) -> None:
    print(f"{COLOR_RED}error: {message}.{COLOR_RESET}")
    sys.exit(1)


def confirm(msg: str) -> bool:
    raw_input = input(f"\n{COLOR_BLUE}{msg} (Y/n): {COLOR_RESET}")
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


@dataclass
class Config:
    base_packages: list[str]
    flatpak_packages: list[str]

    @staticmethod
    def parse():
        with open("config.toml", "rb") as f:
            return Config(**tomllib.load(f))


def main() -> None:
    config = Config.parse()
    if confirm("Update repo lists?"):
        update_repos()

    if confirm("Install base packages?"):
        install_packages(config.base_packages)

    if confirm("Install flatpaks?"):
        install_flatpaks(config.flatpak_packages)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("ctrl+c: exiting...")
    except Exception as ex:
        exit(str(ex))