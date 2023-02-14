from dataclasses import dataclass
import os
import json
from modules.logging import log


@dataclass
class FlatpakConfig:
    remote_url: str
    packages: list[str]


class Config:
    def __init__(self) -> None:
        log("reading config.json file")
        config_file: str = os.getcwd() + "/config.json"

        if not os.path.isfile(config_file):
            raise Exception(f"config file not found: {config_file}")

        with open(config_file, "rt") as file:
            self.raw_config = json.load(file)

    """
      flatpak configuration path in the config.json is config > flatpak 
    """

    def get_flatpak_config(self) -> FlatpakConfig:
        config = self.raw_config.get("flatpak")
        if not config:
            raise Exception(
                "key 'flatpak' missing from the configuration file")

        remote_url = config.get("remote_url")
        packages = config.get("packages")

        if not remote_url:
            raise Exception(
                "key 'remote_url' missing from flatpak configuration object")

        if not packages:
            raise Exception(
                "key 'packages' missing from flatpak configuration object")

        return FlatpakConfig(remote_url, packages)

    """
      flatpak configuration path in the config.json is config > packages
    """

    def get_apt_config(self) -> list[str]:
        packages = self.raw_config.get("packages")
        if not packages:
            raise Exception(
                "key 'packages' missing from the configuration file")

        return list(packages)
