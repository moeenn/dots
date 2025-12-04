use std::process::{Command, Stdio};

pub const COLOR_RED: &str = "\x1b[31m";
pub const COLOR_RESET: &str = "\x1b[0m";

enum Action {
    Help,
    Update,
    Clean,
    Search(String),
    Install(Vec<String>),
    Remove(Vec<String>),
}

enum ParseActionError {
    CommandMissing,
    InvalidCommand,
    SearchPackageMissing,
    PackagesMissing,
}

impl std::fmt::Display for ParseActionError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            ParseActionError::CommandMissing => write!(f, "please provide a command to continue"),
            ParseActionError::InvalidCommand => write!(f, "unrecognized command provided"),
            ParseActionError::SearchPackageMissing => {
                write!(f, "please provde a package name to search")
            }
            ParseActionError::PackagesMissing => {
                write!(f, "please provide package(s) to perform action")
            }
        }
    }
}

fn parse_action(args: Vec<String>) -> Result<Action, ParseActionError> {
    let raw_cmd_opt = args.get(0);

    match raw_cmd_opt {
        None => Err(ParseActionError::CommandMissing),
        Some(cmd) => match cmd.as_str() {
            "help" | "h" => Ok(Action::Help),
            "update" | "u" => Ok(Action::Update),
            "clean" | "c" => Ok(Action::Clean),
            "search" | "s" => match args.get(1) {
                None => Err(ParseActionError::SearchPackageMissing),
                Some(pkg) => Ok(Action::Search(pkg.to_owned())),
            },
            "install" | "i" => match args.len() {
                1 => Err(ParseActionError::PackagesMissing),
                _ => Ok(Action::Install(Vec::from(&args[1..]))),
            },
            "remove" | "r" => match args.len() {
                1 => Err(ParseActionError::PackagesMissing),
                _ => Ok(Action::Remove(Vec::from(&args[1..]))),
            },
            _ => Err(ParseActionError::InvalidCommand),
        },
    }
}

fn print_help() -> Result<(), ActionError> {
    let help = "usage: pkg [COMMAND] [PACKAGES]

commands:
    help     (h)   display this help message and exit.
    search   (s)   search for a single package.
    instal   (i)   install new packages.
    update   (u)   update installed packages.
    remove   (r)   remove provided packages.
    clean    (c)   remove orphan packages.
    ";

    println!("{}", help);
    Ok(())
}

enum ActionError {
    MirrorsUpdateFailed,
    SystemUpgradeFailed,
    FlatpakUpdateFailed,
    FlatpakCleanFailed,
    PackagesCleanFailed,
    PackageSearchFailed,
    PackagesInstallFailed,
    PackagesRemoveFailed,
}

impl std::fmt::Display for ActionError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            ActionError::MirrorsUpdateFailed => write!(f, "failed to update mirrors"),
            ActionError::SystemUpgradeFailed => write!(f, "failed to upgrade system packages"),
            ActionError::FlatpakUpdateFailed => write!(f, "failed to update flatpaks"),
            ActionError::FlatpakCleanFailed => write!(f, "failed to clean flatpaks"),
            ActionError::PackagesCleanFailed => write!(f, "failed to cleanup packages"),
            ActionError::PackageSearchFailed => write!(f, "failed to search packages"),
            ActionError::PackagesInstallFailed => write!(f, "failed to install packages"),
            ActionError::PackagesRemoveFailed => write!(f, "failed to remove packages"),
        }
    }
}

fn pkgs_update_mirrors() -> Result<(), ActionError> {
    let mut cmd = Command::new("sudo");
    cmd.arg("apt-get").arg("update").arg("-y");

    match cmd.status().is_ok() {
        true => Ok(()),
        false => Err(ActionError::MirrorsUpdateFailed),
    }
}

fn pkgs_upgrade() -> Result<(), ActionError> {
    let mut cmd = Command::new("sudo");
    cmd.arg("apt-get").arg("upgrade").arg("-y");
    match cmd.status().is_ok() {
        true => Ok(()),
        false => Err(ActionError::SystemUpgradeFailed),
    }
}

fn is_flatpak_installed() -> bool {
    let mut cmd = Command::new("which");
    cmd.arg("flatpak")
        .stdout(Stdio::null())
        .stderr(Stdio::null());

    cmd.status().is_ok()
}

fn flatpaks_update() -> Result<(), ActionError> {
    let mut cmd = Command::new("sudo");
    cmd.arg("flatpak").arg("update").arg("-y");

    match cmd.status().is_ok() {
        true => Ok(()),
        false => Err(ActionError::FlatpakUpdateFailed),
    }
}

fn flatpaks_clean() -> Result<(), ActionError> {
    let mut cmd = Command::new("sudo");
    cmd.arg("flatpak").arg("uninstall").arg("--unused");

    match cmd.status().is_ok() {
        true => Ok(()),
        false => Err(ActionError::FlatpakCleanFailed),
    }
}

fn pkgs_update() -> Result<(), ActionError> {
    pkgs_update_mirrors()?;
    pkgs_upgrade()?;

    if is_flatpak_installed() {
        println!("\nupdating flatpak packages.");
        flatpaks_update()?;
    }

    Ok(())
}

fn pkgs_clean() -> Result<(), ActionError> {
    let mut cmd = Command::new("sudo");
    cmd.arg("apt-get")
        .arg("autoremove")
        .arg("--purge")
        .arg("-y");

    if !cmd.status().is_ok() {
        return Err(ActionError::PackagesCleanFailed);
    }

    if is_flatpak_installed() {
        println!("\ncleaning flatpak packages.");
        flatpaks_clean()?;
    }

    Ok(())
}

fn pkgs_search(pkg: &String) -> Result<(), ActionError> {
    let mut cmd = Command::new("apt-cache");
    cmd.arg("search").arg(pkg);

    match cmd.status().is_ok() {
        true => Ok(()),
        false => Err(ActionError::PackageSearchFailed),
    }
}

fn pkgs_install(pkgs: &Vec<String>) -> Result<(), ActionError> {
    let mut cmd = Command::new("sudo");
    cmd.arg("apt-get").arg("install").arg("-y");

    for pkg in pkgs.iter() {
        cmd.arg(pkg);
    }

    match cmd.status().is_ok() {
        true => Ok(()),
        false => Err(ActionError::PackagesInstallFailed),
    }
}

fn pkgs_remove(pkgs: &Vec<String>) -> Result<(), ActionError> {
    let mut cmd = Command::new("sudo");
    cmd.arg("apt-get").arg("remove").arg("-y");

    for pkg in pkgs.iter() {
        cmd.arg(pkg);
    }

    match cmd.status().is_ok() {
        true => Ok(()),
        false => Err(ActionError::PackagesRemoveFailed),
    }
}

fn process_action(action: &Action) -> Result<(), ActionError> {
    match action {
        Action::Help => print_help(),
        Action::Update => pkgs_update(),
        Action::Clean => pkgs_clean(),
        Action::Search(pkg) => pkgs_search(pkg),
        Action::Install(pkgs) => pkgs_install(pkgs),
        Action::Remove(pkgs) => {
            pkgs_remove(pkgs)?;
            pkgs_clean()
        }
    }
}

fn main() {
    let args: Vec<String> = std::env::args().skip(1).collect();
    let action_result = parse_action(args);

    match action_result {
        Err(e) => {
            eprintln!("{}error: {}.{}", COLOR_RED, e, COLOR_RESET);
            std::process::exit(1);
        }
        Ok(action) => match process_action(&action) {
            Ok(_) => {}
            Err(e) => {
                eprintln!("{}error: {}.{}", COLOR_RED, e, COLOR_RESET);
                std::process::exit(1);
            }
        },
    }
}
