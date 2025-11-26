pub enum ExecutionError {
    MirrorsUpdateFailed,
    BasePackageInstallationFailed,
}

impl std::fmt::Display for ExecutionError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            ExecutionError::MirrorsUpdateFailed => {
                write!(f, "failed to update packae manager mirrors")
            }
            ExecutionError::BasePackageInstallationFailed => {
                write!(f, "failed to install base packages")
            }
        }
    }
}

pub trait Executable {
    fn execute(&self) -> Result<(), ExecutionError>;
}
