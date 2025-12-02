use crate::log;
use std::io::Write;

pub fn confirm(message: &'static str) -> bool {
    print!(
        "\n{}{} [y/n]{} ",
        log::COLOR_BLUE,
        message,
        log::COLOR_RESET
    );
    match std::io::stdout().flush() {
        Ok(_) => {}
        Err(_) => return false,
    };

    let mut user_input = String::new();
    match std::io::stdin().read_line(&mut user_input) {
        Err(_) => false,
        Ok(_) => match user_input.trim() {
            "y" | "Y" => true,
            _ => false,
        },
    }
}
