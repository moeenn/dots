from enum import Enum


class Colors(str, Enum):
    RED = "\033[41;30m"
    BLUE = "\033[44;30m"
    RESET = "\033[0m"


class Level(str, Enum):
    INFO = "INFO"
    ERROR = "ERROR"


def log(message: str, level: Level = Level.INFO) -> None:
    match level:
        case level.INFO:
            print(f"\n{Colors.BLUE} {message} {Colors.RESET}")

        case level.ERROR:
            print(f"\n{Colors.RED} {message} {Colors.RESET}")
