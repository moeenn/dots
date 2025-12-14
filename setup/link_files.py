#! /bin/python3

import os


def get_home() -> str:
    home = os.getenv("HOME")
    if not home or home == "":
        raise Exception("failed to determine $HOME")
    return home


def link_files(src_path: str, target_path) -> None:
    dir_entries = os.listdir(src_path)
    if not os.path.exists(target_path):
        os.mkdir(target_path)

    for entry in dir_entries:
        src = os.path.join(src_path, entry)
        dst = os.path.join(target_path, entry)

        if os.path.exists(dst):
            is_link = os.path.islink(dst)
            if is_link:
                os.remove(dst)
            else:
                backup = os.path.join(target_path, f"{entry}.old")
                os.rename(dst, backup)

        print(f"linking: {dst}")
        os.symlink(src, dst)


def main() -> None:
    """link $HOME files"""
    target_dir = get_home()
    home_configs = os.path.join(os.getcwd(), "..", "configs", "home")
    link_files(home_configs, target_dir)

    """ link XDG_CONFIG files """
    target_dir = os.path.join(target_dir, ".config")
    xdg_configs = os.path.join(os.getcwd(), "..", "configs", "config")
    link_files(xdg_configs, target_dir)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\nctrl+c: exiting...")
    except Exception as ex:
        print(f"error: {str(ex)}")
