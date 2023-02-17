from typing import Callable

"""
    add common erorr handling to a (main) function
"""


def entrypoint(func: Callable[[], None]) -> Callable[[], None]:
    def wrapper() -> None:
        try:
            func()
        except KeyboardInterrupt:
            print("ctrl+c: shutting down...")
        except Exception as err:
            print("error:", err)

    return wrapper
