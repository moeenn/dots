pub enum ExecutionError {
    UsernameReadFailed,
    HomePathReadFailed,
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
    GoDownloadFailed,
    GoDownloadFileCreateFailed,
    GoDownloadInvalidResponse,
    GoDownloadCopyError,
    GoDownloadFileReadFailed,
    GoInstallerExtractFailed,
    GoPrevVersionCleanupFailed,
    GoInstallerMoveFailed,
    GoPackageInstallationFailed,
    PythonInstallationFailed,
    PythonPipPackagesInstallationFailed,
    JavaInstallationFailed,
    XorgPackagesInstallationFailed,
    NodeInstallationFailed,
    NodeSetPrefixFailed,
    NodeGlobalPackagesInstallationFailed,
}

impl std::fmt::Display for ExecutionError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            ExecutionError::UsernameReadFailed => {
                write!(f, "failed to read $USER variable")
            }
            ExecutionError::HomePathReadFailed => {
                write!(f, "failed to read $HOME variable")
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
            ExecutionError::GoDownloadFailed => {
                write!(f, "failed to download go installer")
            }
            ExecutionError::GoDownloadFileCreateFailed => {
                write!(f, "failed to create download file on disk")
            }
            ExecutionError::GoDownloadInvalidResponse => {
                write!(
                    f,
                    "unexpected response received when downloading go installer"
                )
            }
            ExecutionError::GoDownloadCopyError => {
                write!(f, "failed to write go installer archive into download file")
            }
            ExecutionError::GoDownloadFileReadFailed => {
                write!(f, "failed to read go installer")
            }
            ExecutionError::GoInstallerExtractFailed => {
                write!(f, "failed to extract go installer")
            }
            ExecutionError::GoPrevVersionCleanupFailed => {
                write!(f, "failed to remove previous go installation files")
            }
            ExecutionError::GoInstallerMoveFailed => {
                write!(f, "failed to move install go files")
            }
            ExecutionError::GoPackageInstallationFailed => {
                write!(f, "failed to install go package")
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
            ExecutionError::NodeInstallationFailed => {
                write!(f, "failed to install nodejs")
            }
            ExecutionError::NodeSetPrefixFailed => {
                write!(f, "failed to get prefix config")
            }
            ExecutionError::NodeGlobalPackagesInstallationFailed => {
                write!(f, "failed to install global packages")
            }
        }
    }
}

pub trait Executable {
    fn execute(&self) -> Result<(), ExecutionError>;
}
