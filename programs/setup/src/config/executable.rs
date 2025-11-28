pub enum ExecutionError {
    UsernameReadFailed,
    MirrorsUpdateFailed,
    BasePackageInstallationFailed,
    CommonAppsInstallationFailed,
    FlatpakSupportInstallationFailed,
    FlatpakConfigurationFailed,
    FlatpkaInstalltionFailed,
    DockerInstallationFailed,
    DockerGroupAddFailed,
    DockerUserGroupAddFailed,
    FishInstallFailed,
    FishLocationDetectFailed,
    FishSetDefaultFailed,
    PythonInstallationFailed,
    PythonPipPackagesInstallationFailed,
    JavaInstallationFailed,
    XorgPackagesInstallationFailed,
}

impl std::fmt::Display for ExecutionError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            ExecutionError::UsernameReadFailed => {
                write!(f, "failed to read $USER variable")
            }
            ExecutionError::MirrorsUpdateFailed => {
                write!(f, "failed to update packae manager mirrors")
            }
            ExecutionError::BasePackageInstallationFailed => {
                write!(f, "failed to install base packages")
            }
            ExecutionError::CommonAppsInstallationFailed => {
                write!(f, "failed to install common application")
            }
            ExecutionError::FlatpakSupportInstallationFailed => {
                write!(f, "failed to install flatpak support")
            }
            ExecutionError::FlatpakConfigurationFailed => {
                write!(f, "failed to configure flatpak repository")
            }
            ExecutionError::FlatpkaInstalltionFailed => {
                write!(f, "failed to install flatpaks")
            }
            ExecutionError::DockerInstallationFailed => {
                write!(f, "failed to install docker support")
            }
            ExecutionError::DockerGroupAddFailed => {
                write!(f, "failed to add docker group to the system")
            }
            ExecutionError::DockerUserGroupAddFailed => {
                write!(f, "failed to add current user to docker group")
            }
            ExecutionError::FishInstallFailed => {
                write!(f, "failed to install fish shell")
            }
            ExecutionError::FishLocationDetectFailed => {
                write!(f, "failed to determine fish shell installation location")
            }
            ExecutionError::FishSetDefaultFailed => {
                write!(f, "failed to set fish shell as default")
            }
            ExecutionError::PythonInstallationFailed => {
                write!(f, "failed to install python")
            }
            ExecutionError::PythonPipPackagesInstallationFailed => {
                write!(f, "failed to install python pip packages")
            }
            ExecutionError::JavaInstallationFailed => {
                write!(f, "failed to install java")
            }
            ExecutionError::XorgPackagesInstallationFailed => {
                write!(f, "failed to install xorg related packages")
            }
        }
    }
}

pub trait Executable {
    fn execute(&self) -> Result<(), ExecutionError>;
}
