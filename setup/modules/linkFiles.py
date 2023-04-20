import os

"""
    return the path for the current user's home
"""


def home() -> str:
    home_path: str | None = os.getenv("HOME")
    if not home_path:
        raise Exception("$HOME not set in system env")

    return home_path


"""
    return path to the directory containing configs
"""


def configs_dir() -> str:
    return os.getcwd() + "/configs"


"""
    rename file / folder, adding '.old' at the end of filename
"""


def create_backup(file_path: str) -> None:
    if not os.path.exists(file_path):
        raise Exception(f"file not found: {file_path}")

    new_path: str = file_path + ".old"
    os.rename(file_path, new_path)


"""
    link all files in the src dir to target dir
"""


def link_files(src_dir: str, target_dir: str) -> None:
    if not os.path.isdir(src_dir):
        raise Exception(f"not a valid directory (src_dir): {src_dir}")

    if not os.path.isdir(target_dir):
        raise Exception(f"not a valid directory (target_dir): {target_dir}")

    src_content: list[str] = os.listdir(src_dir)
    for item in src_content:
        target_path: str = f"{target_dir}/{item}"
        if os.path.exists(target_path):
            create_backup(target_path)

        src_path: str = f"{src_dir}/{item}"
        os.symlink(src_path, target_path)
        print(f"linking: {src_path} -> {target_path}")
