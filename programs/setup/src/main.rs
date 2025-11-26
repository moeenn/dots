mod config;
mod log;
use config::LoadError;

/// TODO
/// - [ ] read config file path using flags (allow for default value).

fn main() {
    let config_path = "./config.toml";
    let parsed_config = match config::load(config_path) {
        Ok(c) => c,
        Err(err) => {
            let msg = match err {
                LoadError::ReadError => "failed to read config file",
                LoadError::InvalidConfig => "invalid configuration file",
            };

            log::error(msg);
            std::process::exit(1);
        }
    };

    match parsed_config.execute() {
        Ok(_) => println!("Setup successfull."),
        Err(err) => {
            eprintln!("{}error: {}.{}", log::COLOR_RED, err, log::COLOR_RESET);
            std::process::exit(1);
        }
    }
}
