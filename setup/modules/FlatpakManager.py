import subprocess
from modules.logging import log

"""
    installs and configures flatpak support on the system
    also provides mechanism for installation of flatpak packages
"""


class FlatpakManager:
    def __init__(self, remote_url: str) -> None:
        self.install_base()
        self.configure_remote(remote_url)

    def install_base(self) -> None:
        log("installing flatpak support")
        subprocess.run(["sudo", "apt-get", "install", "-y", "flatpak"])

    def configure_remote(self, remote_url: str) -> None:
        log("configuring flatpak remote")
        subprocess.run(["flatpak", "remote-add", "--if-not-exists",
                        "flathub", remote_url])

    def install_packages(self, packages: list[str]) -> None:
        log("installing flatpak packages")
        install_cmd = ["sudo", "flatpak", "install", "flathub", "-y"]
        subprocess.run(install_cmd + packages)
