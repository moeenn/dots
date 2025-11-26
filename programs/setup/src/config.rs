mod executable;
use executable::{Executable, ExecutionError};

use crate::log;
use serde::Deserialize;
use std::{fs, process::Command};
use toml;

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
}

impl Executable for ConfigSystemPackages {
    fn execute(&self) -> Result<(), ExecutionError> {
        log::info("\nupdating mirrors");
        self.update_pm_mirrors()?;

        log::info("\ninstalling base packages");
        self.install_base_packages()?;
        Ok(())
    }
}

#[derive(Deserialize)]
pub struct ConfigFlatpak {
    system_packages: Vec<String>,
    packages: Vec<String>,
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

#[derive(Deserialize)]
pub struct ConfigJava {
    system_packages: Vec<String>,
}

#[derive(Deserialize)]
pub struct ConfigDocker {
    system_packages: Vec<String>,
}

#[derive(Deserialize)]
pub struct ConfigXorg {
    system_packages: Vec<String>,
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
