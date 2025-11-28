mod executable;
use executable::{Executable, ExecutionError};

use crate::log;
use serde::Deserialize;
use std::{fs, process::Command};
use toml;

fn get_username() -> Result<String, ExecutionError> {
    match std::env::var("USER") {
        Ok(user) => Ok(user),
        Err(_) => Err(ExecutionError::UsernameReadFailed),
    }
}

#[derive(Deserialize)]
pub struct ConfigSystemPackages {
    base_packages: Vec<String>,
    common_apps: Vec<String>,
}

impl ConfigSystemPackages {
    fn update_pm_mirrors(&self) -> Result<(), ExecutionError> {
        let mut cmd = Command::new("sudo");
        cmd.arg("apt-get").arg("update").arg("-y");
        match cmd.status().is_ok() {
            true => Ok(()),
            false => Err(ExecutionError::MirrorsUpdateFailed),
        }
    }

    fn install_base_packages(&self) -> Result<(), ExecutionError> {
        let mut cmd = Command::new("sudo");
        cmd.arg("apt-get").arg("install").arg("-y");
        for pkg in self.base_packages.iter() {
            cmd.arg(pkg);
        }

        match cmd.status().is_ok() {
            true => Ok(()),
            false => Err(ExecutionError::BasePackageInstallationFailed),
        }
    }

    fn install_common_apps(&self) -> Result<(), ExecutionError> {
        let mut cmd = Command::new("sudo");
        cmd.arg("apt-get").arg("install").arg("-y");
        for app in self.common_apps.iter() {
            cmd.arg(app);
        }

        match cmd.status().is_ok() {
            true => Ok(()),
            false => Err(ExecutionError::CommonAppsInstallationFailed),
        }
    }
}

impl Executable for ConfigSystemPackages {
    fn execute(&self) -> Result<(), ExecutionError> {
        log::info("\nupdating mirrors");
        self.update_pm_mirrors()?;

        log::info("\ninstalling base packages");
        self.install_base_packages()?;

        log::info("\ninstalling common apps");
        self.install_common_apps()?;
        Ok(())
    }
}

#[derive(Deserialize)]
pub struct ConfigFlatpak {
    packages: Vec<String>,
}

impl ConfigFlatpak {
    fn install_flatpak_support(&self) -> Result<(), ExecutionError> {
        let mut cmd = Command::new("sudo");
        cmd.arg("apt-get").arg("install").arg("-y").arg("flatpak");

        match cmd.status().is_ok() {
            true => Ok(()),
            false => Err(ExecutionError::FlatpakSupportInstallationFailed),
        }
    }

    fn configrure_flatpaks(&self) -> Result<(), ExecutionError> {
        let mut cmd = Command::new("sudo");
        cmd.arg("flatpak")
            .arg("remote-add")
            .arg("--if-not-exists")
            .arg("flathub")
            .arg("https://dl.flathub.org/repo/flathub.flatpakrepo");

        match cmd.status().is_ok() {
            true => Ok(()),
            false => Err(ExecutionError::FlatpakConfigurationFailed),
        }
    }

    fn install_flatpaks(&self) -> Result<(), ExecutionError> {
        let mut cmd = Command::new("sudo");
        cmd.arg("flatpak").arg("install").arg("flathub").arg("-y");
        for pkg in self.packages.iter() {
            cmd.arg(pkg);
        }

        match cmd.status().is_ok() {
            true => Ok(()),
            false => Err(ExecutionError::FlatpkaInstalltionFailed),
        }
    }
}

impl Executable for ConfigFlatpak {
    fn execute(&self) -> Result<(), ExecutionError> {
        log::info("\ninstalling flatpak support");
        self.install_flatpak_support()?;

        log::info("\nconfiguring flatpak repositories");
        self.configrure_flatpaks()?;

        log::info("\ninstalling flatpaks");
        self.install_flatpaks()?;
        Ok(())
    }
}

#[derive(Deserialize)]
pub struct ConfigDocker {
    system_packages: Vec<String>,
}

impl ConfigDocker {
    fn install_support(&self) -> Result<(), ExecutionError> {
        let mut cmd = Command::new("sudo");
        cmd.arg("apt-get").arg("install").arg("-y");
        for pkg in self.system_packages.iter() {
            cmd.arg(pkg);
        }

        match cmd.status().is_ok() {
            true => Ok(()),
            false => Err(ExecutionError::DockerInstallationFailed),
        }
    }

    fn add_docker_group(&self) -> Result<(), ExecutionError> {
        let mut cmd = Command::new("sudo");
        cmd.arg("groupadd").arg("docker");

        match cmd.status().is_ok() {
            true => Ok(()),
            false => Err(ExecutionError::DockerGroupAddFailed),
        }
    }

    fn add_user_to_docker_group(&self, user: String) -> Result<(), ExecutionError> {
        let mut cmd = Command::new("sudo");
        cmd.arg("usermod").arg("-aG").arg("docker").arg(user);

        match cmd.status().is_ok() {
            true => Ok(()),
            false => Err(ExecutionError::DockerUserGroupAddFailed),
        }
    }
}

impl Executable for ConfigDocker {
    fn execute(&self) -> Result<(), ExecutionError> {
        log::info("\ninstalling docker support");
        self.install_support()?;

        log::info("\nadding docker group to the system");
        self.add_docker_group()?;

        let user = get_username()?;
        log::info("\nadding current user to the docker group");
        self.add_user_to_docker_group(user)?;

        Ok(())
    }
}

pub struct ConfigFish {}

impl ConfigFish {
    fn install_fish(&self) -> Result<(), ExecutionError> {
        let mut cmd = Command::new("sudo");
        cmd.arg("apt-get").arg("install").arg("-y").arg("fish");

        match cmd.status().is_ok() {
            true => Ok(()),
            false => Err(ExecutionError::FishInstallFailed),
        }
    }

    fn whereis_fish(&self) -> Result<String, ExecutionError> {
        let mut cmd = Command::new("which");
        cmd.arg("fish");

        match cmd.output() {
            Err(_) => Err(ExecutionError::FishLocationDetectFailed),
            Ok(out) => match String::from_utf8(out.stdout) {
                Ok(p) => Ok(p.trim().to_owned()),
                Err(_) => Err(ExecutionError::FishLocationDetectFailed),
            },
        }
    }

    fn set_fish_as_default(
        &self,
        user: String,
        fish_location: String,
    ) -> Result<(), ExecutionError> {
        let mut cmd = Command::new("sudo");
        cmd.arg("usermod").arg("-s").arg(fish_location).arg(user);

        match cmd.status().is_ok() {
            true => Ok(()),
            false => Err(ExecutionError::FishSetDefaultFailed),
        }
    }
}

impl Executable for ConfigFish {
    fn execute(&self) -> Result<(), ExecutionError> {
        log::info("\ninstalling fish shell");
        self.install_fish()?;

        let username = get_username()?;
        let fish_location = self.whereis_fish()?;

        log::info("\nsetting fish as default shell");
        self.set_fish_as_default(username, fish_location)?;

        Ok(())
    }
}

#[derive(Deserialize)]
pub struct ConfigNodeJs {
    version: i32,
    global_deps: Vec<String>,
}

#[derive(Deserialize)]
pub struct ConfigCpp {
    llvm_version: i32,
    gcc_version: i32,
    packages: Vec<String>,
}

#[derive(Deserialize)]
pub struct ConfigPython {
    system_packages: Vec<String>,
    pip_packages: Vec<String>,
}

impl ConfigPython {
    fn install_packages(&self) -> Result<(), ExecutionError> {
        let mut cmd = Command::new("sudo");
        cmd.arg("apt-get").arg("install").arg("-y");
        for pkg in self.system_packages.iter() {
            cmd.arg(pkg);
        }

        match cmd.status().is_ok() {
            true => Ok(()),
            false => Err(ExecutionError::PythonInstallationFailed),
        }
    }

    fn install_pip_packages(&self) -> Result<(), ExecutionError> {
        let mut cmd = Command::new("pipx");
        cmd.arg("install");
        for pkg in self.pip_packages.iter() {
            cmd.arg(pkg);
        }

        match cmd.status().is_ok() {
            true => Ok(()),
            false => Err(ExecutionError::PythonPipPackagesInstallationFailed),
        }
    }
}

impl Executable for ConfigPython {
    fn execute(&self) -> Result<(), ExecutionError> {
        log::info("\ninstalling python");
        self.install_packages()?;

        log::info("\ninstalling pip packages");
        self.install_pip_packages()?;

        Ok(())
    }
}

#[derive(Deserialize)]
pub struct ConfigJava {
    system_packages: Vec<String>,
}

impl ConfigJava {
    fn install_packages(&self) -> Result<(), ExecutionError> {
        let mut cmd = Command::new("sudo");
        cmd.arg("apt-get").arg("install").arg("-y");

        for pkg in self.system_packages.iter() {
            cmd.arg(pkg);
        }

        match cmd.status().is_ok() {
            true => Ok(()),
            false => Err(ExecutionError::JavaInstallationFailed),
        }
    }
}

impl Executable for ConfigJava {
    fn execute(&self) -> Result<(), ExecutionError> {
        log::info("\ninstalling java");
        self.install_packages()?;
        Ok(())
    }
}

#[derive(Deserialize)]
pub struct ConfigXorg {
    system_packages: Vec<String>,
}

impl ConfigXorg {
    fn install_packages(&self) -> Result<(), ExecutionError> {
        let mut cmd = Command::new("sudo");
        cmd.arg("apt-get").arg("install").arg("-y");
        for pkg in self.system_packages.iter() {
            cmd.arg(pkg);
        }

        match cmd.status().is_ok() {
            true => Ok(()),
            false => Err(ExecutionError::XorgPackagesInstallationFailed),
        }
    }
}

impl Executable for ConfigXorg {
    fn execute(&self) -> Result<(), ExecutionError> {
        log::info("\ninstalling xorg packages");
        self.install_packages()?;
        Ok(())
    }
}

#[derive(Deserialize)]
pub struct Config {
    system_packages: ConfigSystemPackages,
    flatpak: ConfigFlatpak,
    docker: ConfigDocker,
    nodejs: ConfigNodeJs,
    java: ConfigJava,
    cpp: ConfigCpp,
    python: ConfigPython,
    xorg: ConfigXorg,
}

impl Config {
    pub fn execute(&self) -> Result<(), ExecutionError> {
        self.system_packages.execute()?;
        self.flatpak.execute()?;
        self.docker.execute()?;
        self.xorg.execute()?;

        let fish = ConfigFish {};
        fish.execute()?;

        self.python.execute()?;
        self.java.execute()?;

        // TODO:
        // - implement cpp.
        // - implment nodejs.

        Ok(())
    }
}

pub enum LoadError {
    ReadError,
    InvalidConfig,
}

pub fn load(config_path: &'static str) -> Result<Config, LoadError> {
    let file_content = match fs::read_to_string(config_path) {
        Ok(content) => content,
        Err(_) => return Err(LoadError::ReadError),
    };

    match toml::from_str::<Config>(&file_content) {
        Ok(config) => Ok(config),
        Err(err) => {
            eprintln!(
                "{}error: {}.{}",
                log::COLOR_RED,
                err.message(),
                log::COLOR_RESET
            );
            return Err(LoadError::InvalidConfig);
        }
    }
}
