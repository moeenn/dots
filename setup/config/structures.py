class AptConfig:
    packages: list[str]

    def __init__(self, packages: list[str] | None) -> None:
        if not packages:
            raise Exception("invalid config, apt.packages missing")

        self.packages = packages


class FlatpakConfig:
    remote_url: str
    packages: list[str]

    def __init__(self, remote_url: str | None, packages: list[str] | None) -> None:
        if not remote_url:
            raise Exception("invalid config, flatpak.remote_url missing")

        if not packages:
            raise Exception("invalid config, flatpak.packages missing")

        self.remote_url = remote_url
        self.packages = packages


class PythonConfig:
    packages: list[str]

    def __init__(self, packages: list[str] | None) -> None:
        if not packages:
            raise Exception("invalid config, python.packages missing")

        self.packages = packages


class Config:
    apt: AptConfig
    flatpak: FlatpakConfig
    python: PythonConfig

    def __init__(self, apt: dict, flatpak: dict, python: dict) -> None:
        self.apt = AptConfig(**apt)
        self.flatpak = FlatpakConfig(**flatpak)
        self.python = PythonConfig(**python)
