mod confirm;
mod executable;

use crate::log;
use confirm::confirm;
use executable::{Executable, ExecutionError};
use flate2::read::GzDecoder;
use reqwest::blocking::Client;
use serde::Deserialize;
use std::{fs, process::Command};
use std::{fs::File, path::PathBuf};
use tar::Archive;
use toml;

fn get_username() -> Result<String, ExecutionError> {
    match std::env::var("USER") {
        Ok(user) => Ok(user),
        Err(_) => Err(ExecutionError::UsernameReadFailed),
    }
}

fn get_home() -> Result<String, ExecutionError> {
    match std::env::var("HOME") {
        Ok(home) => Ok(home),
        Err(_) => Err(ExecutionError::HomePathReadFailed),
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
        if confirm("Update mirrors?") {
            log::info("updating mirrors");
            self.update_pm_mirrors()?;
        }

        if confirm("Install base packages?") {
            log::info("installing base packages");
            self.install_base_packages()?;
        }

        if confirm("Install common apps?") {
            log::info("installing common apps");
            self.install_common_apps()?;
        }

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
        if confirm("Add flatpak support?") {
            log::info("installing flatpak support");
            self.install_flatpak_support()?;

            log::info("configuring flatpak repositories");
            self.configrure_flatpaks()?;
        }

        if confirm("Install flatpaks?") {
            log::info("installing flatpaks");
            self.install_flatpaks()?;
        }

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
        if confirm("Install and configure docker?") {
            log::info("installing docker support");
            self.install_support()?;

            log::info("adding docker group to the system");
            self.add_docker_group()?;

            let user = get_username()?;
            log::info("adding current user to the docker group");
            self.add_user_to_docker_group(user)?;
        }

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
        log::info("installing fish shell");
        self.install_fish()?;

        let username = get_username()?;
        let fish_location = self.whereis_fish()?;

        log::info("setting fish as default shell");
        self.set_fish_as_default(username, fish_location)?;

        Ok(())
    }
}

#[derive(Deserialize)]
pub struct ConfigGo {
    version: String,
    packages: Vec<String>,
}

impl ConfigGo {
    fn get_filename(&self) -> String {
        format!("go{}.linux-amd64.tar.gz", self.version)
    }

    fn download_installer(&self) -> Result<PathBuf, ExecutionError> {
        let filename = self.get_filename();
        let url = format!("https://go.dev/dl/{}", filename);

        let mut download_path = std::env::temp_dir();
        download_path.push(filename);

        // if the file already exists, no need to re-download.
        if download_path.exists() {
            return Ok(download_path);
        }

        let client = Client::new();
        let req = match client.get(url).send() {
            Ok(r) => r,
            Err(_) => return Err(ExecutionError::GoDownloadFailed),
        };

        let mut download_file = match File::create(&download_path) {
            Ok(f) => f,
            Err(_) => return Err(ExecutionError::GoDownloadFileCreateFailed),
        };

        let res = match req.bytes() {
            Ok(b) => b,
            Err(_) => return Err(ExecutionError::GoDownloadInvalidResponse),
        };

        match std::io::copy(&mut res.as_ref(), &mut download_file) {
            Ok(_) => {}
            Err(_) => return Err(ExecutionError::GoDownloadCopyError),
        };

        Ok(download_path)
    }

    fn extract_installer(&self, download_path: &PathBuf) -> Result<PathBuf, ExecutionError> {
        let downloaded_file = match File::open(download_path) {
            Ok(f) => f,
            Err(_) => return Err(ExecutionError::GoDownloadFileReadFailed),
        };

        let gz_decoder = GzDecoder::new(downloaded_file);
        let mut archive = Archive::new(gz_decoder);

        let mut extract_folder = std::env::temp_dir();
        match archive.unpack(&extract_folder) {
            Ok(_) => {
                extract_folder.push("go");
                return Ok(extract_folder);
            }
            Err(_) => return Err(ExecutionError::GoInstallerExtractFailed),
        }
    }

    fn place_in_path(&self, source_folder: &PathBuf) -> Result<(), ExecutionError> {
        let homepath = match get_home() {
            Ok(p) => p,
            Err(e) => return Err(e),
        };

        let mut target_path = PathBuf::new();
        target_path.push(homepath);
        target_path.push(".local");
        target_path.push("go");

        if target_path.exists() {
            match std::fs::remove_dir_all(&target_path) {
                Ok(_) => {}
                Err(_) => return Err(ExecutionError::GoPrevVersionCleanupFailed),
            };
        }

        match dircpy::copy_dir(source_folder, target_path) {
            Ok(_) => Ok(()),
            Err(e) => {
                println!("error: {:?}", e);
                return Err(ExecutionError::GoInstallerMoveFailed);
            }
        }
    }

    fn install_go_package(&self, pkg: &String) -> Result<(), ExecutionError> {
        let mut cmd = Command::new("go");
        cmd.arg("install").arg("-v").arg(pkg);

        match cmd.status().is_ok() {
            true => Ok(()),
            false => Err(ExecutionError::GoPackageInstallationFailed),
        }
    }

    fn install_go_packages(&self) -> Result<(), ExecutionError> {
        for pkg in self.packages.iter() {
            match self.install_go_package(pkg) {
                Ok(_) => continue,
                Err(e) => return Err(e),
            };
        }

        Ok(())
    }
}

impl Executable for ConfigGo {
    fn execute(&self) -> Result<(), ExecutionError> {
        if confirm("Install golang?") {
            log::info("downloading go installer");
            let download_path = self.download_installer()?;

            log::info("extracting installer");
            let extract_path = self.extract_installer(&download_path)?;

            log::info("placing go files in path");
            self.place_in_path(&extract_path)?;
        }

        if confirm("Install go packages?") {
            log::info("installing go packages");
            self.install_go_packages()?;
        }

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
        if confirm("Install and configure python?") {
            log::info("installing python");
            self.install_packages()?;

            log::info("installing pip packages");
            self.install_pip_packages()?;
        }

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
        if confirm("Install java?") {
            log::info("installing java");
            self.install_packages()?;
        }

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
        if confirm("Install xorg packages?") {
            log::info("installing xorg packages");
            self.install_packages()?;
        }

        Ok(())
    }
}

#[derive(Deserialize)]
pub struct Config {
    system_packages: ConfigSystemPackages,
    flatpak: ConfigFlatpak,
    docker: ConfigDocker,
    go: ConfigGo,
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

        if confirm("Install fish?") {
            let fish = ConfigFish {};
            fish.execute()?;
        }

        self.python.execute()?;
        self.java.execute()?;
        self.go.execute()?;
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
