import os
import json
from .structures import Config, FlatpakConfig, AptConfig, DesktopConfig


def load_config() -> Config:
    config_file = "config.json"
    if not os.path.exists(config_file):
        raise Exception(f"{config_file} not found")

    with open(config_file, "rt") as file:
        try:
            raw = json.load(file)
        except Exception as err:
            raise Exception("invalid config.json, " + str(err))
        return Config(**raw)
