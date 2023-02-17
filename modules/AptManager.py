import subprocess
from modules.logging import log


class AptManager:
    def __init__(self) -> None:
        self.update_repos()

    def update_repos(self) -> None:
        log("updating apt repos")
        subprocess.run(["sudo", "apt-get", "update", "-y"])

    def install_packages(self, packages: list[str]) -> None:
        log("installing apt packages")
        install_cmd = ["sudo", "apt-get", "install", "-y"]
        subprocess.run(install_cmd + packages)
