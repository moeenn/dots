use std::env;
use std::process::{self, Command};

const COLOR_RESET: &str = "\x1b[0m";
const COLOR_RED: &str = "\x1b[31m";
const COLOR_BLUE: &str = "\x1b[34m";

const HELP: &str = "usage: pkg [COMMAND] [PACKAGES]

commands:
    help             (h)   display this help message and exit.
    search           (s)   search for a single package.
    install          (i)   install new packages.
    flatpak-install  (fi)  install flatpak packages.
    update           (u)   update installed packages.
    remove           (r)   remove provided packages.
    flatpak-remove   (fr)  remove flatpak packages.
    clean            (c)   remove orphan packages.
";

fn error_out(message: &'static str) {
    eprintln!("{COLOR_RED}error: {message}.{COLOR_RESET}");
    process::exit(1);
}

fn log(message: &'static str) {
    println!("\n{COLOR_BLUE}{message}{COLOR_RESET}");
}

fn execute(cmd: &mut Command) {
    match cmd.status() {
        Err(e) => {
            eprintln!("{COLOR_RED}error: {e}.{COLOR_RESET}");
            process::exit(1);
        }
        Ok(_) => (),
    }
}

fn flatpak_exists() -> bool {
    let mut cmd = Command::new("which");
    cmd.arg("flatpak");
    match cmd.output() {
        Err(_) => false,
        Ok(_) => true,
    }
}

fn flatpak_install(pkgs: &Vec<String>) {
    log("installing flatpaks");
    let mut cmd = Command::new("sudo");
    cmd.arg("flatpak").arg("install").arg("flathub").arg("-y");
    for p in pkgs.iter() {
        cmd.arg(p);
    }
    execute(&mut cmd);
}

fn flatpak_update() {
    log("installing flatpak updates");
    let mut cmd = Command::new("sudo");
    cmd.arg("flatpak").arg("update").arg("-y");
    execute(&mut cmd);
}

fn flatpak_remove(pkgs: &Vec<String>) {
    log("removing flatpaks");
    let mut cmd = Command::new("sudo");
    cmd.arg("flatpak").arg("uninstall").arg("--delete-data");
    for p in pkgs.iter() {
        cmd.arg(p);
    }
    execute(&mut cmd);
}

fn flatpak_clean() {
    log("cleaning flatpaks");
    let mut cmd = Command::new("sudo");
    cmd.arg("flatpak").arg("uninstall").arg("--unused");
    execute(&mut cmd);
}

fn pkg_search(pkg: &String) {
    let mut cmd = Command::new("apt-cache");
    cmd.arg("search").arg(pkg);
    execute(&mut cmd);
}

fn pkg_install(pkgs: &Vec<String>) {
    log("installing packages");
    let mut cmd = Command::new("sudo");
    cmd.arg("apt-get").arg("install").arg("-y");
    for p in pkgs.iter() {
        cmd.arg(p);
    }
    execute(&mut cmd);
}

fn pkg_update() {
    log("updating packages");
    let mut cmd = Command::new("sudo");
    cmd.arg("apt-get").arg("update").arg("-y");
    execute(&mut cmd);
}

fn pkg_upgrade() {
    log("upgrading system");
    let mut cmd = Command::new("sudo");
    cmd.arg("apt-get").arg("upgrade").arg("-y");
    execute(&mut cmd);
}

fn pkg_distupgrade() {
    log("running distribution upgrade");
    let mut cmd = Command::new("sudo");
    cmd.arg("apt-get").arg("dist-upgrade").arg("-y");
    execute(&mut cmd);
}

fn pkg_remove(pkgs: &Vec<String>) {
    log("removing packages");
    let mut cmd = Command::new("sudo");
    cmd.arg("apt-get").arg("remove").arg("-y");
    for p in pkgs.iter() {
        cmd.arg(p);
    }
    execute(&mut cmd);
}

fn pkg_clean() {
    log("cleaning up packages");
    let mut cmd = Command::new("sudo");
    cmd.arg("apt-get")
        .arg("autoremove")
        .arg("--purge")
        .arg("-y");

    execute(&mut cmd);
}

fn main() {
    let args: Vec<String> = env::args().skip(1).collect();
    match args.get(0) {
        None => error_out("please provide a command to continue"),
        Some(arg) => match arg.as_str() {
            "help" | "h" => {
                println!("{}", HELP);
            }
            "update" | "u" => {
                pkg_update();
                pkg_upgrade();
                pkg_distupgrade();
                if flatpak_exists() {
                    flatpak_update();
                }
            }
            "clean" | "c" => {
                pkg_clean();
                if flatpak_exists() {
                    flatpak_clean();
                }
            }
            "install" | "i" => {
                let mut pkgs: Vec<String> = args.clone();
                pkgs.remove(0);
                match pkgs.as_slice() {
                    [] => error_out("please provide at least one package name to install"),
                    _ => pkg_install(&pkgs),
                }
            }
            "flatpak-install" | "fi" => {
                let mut pkgs: Vec<String> = args.clone();
                pkgs.remove(0);
                match pkgs.as_slice() {
                    [] => error_out("please provide at least one package name to install"),
                    _ => flatpak_install(&pkgs),
                }
            }
            "remove" | "r" => {
                let mut pkgs: Vec<String> = args.clone();
                pkgs.remove(0);
                match pkgs.as_slice() {
                    [] => error_out("please provide at least one package name to remove"),
                    _ => pkg_remove(&pkgs),
                }
            }
            "flatpak-remove" | "fr" => {
                let mut pkgs: Vec<String> = args.clone();
                pkgs.remove(0);
                match pkgs.as_slice() {
                    [] => error_out("please provide at least one package name to remove"),
                    _ => flatpak_remove(&pkgs),
                }
            }
            "search" | "s" => match args.get(1) {
                None => error_out("please provide a package name to search"),
                Some(pkg) => pkg_search(pkg),
            },
            _ => error_out("unrecognized command"),
        },
    }
}
