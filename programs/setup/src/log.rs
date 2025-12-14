pub const COLOR_RED: &str = "\x1b[31m";
pub const COLOR_BLUE: &str = "\x1b[34m";
pub const COLOR_RESET: &str = "\x1b[0m";

pub fn info(msg: &'static str) {
    println!("{}{}{}", COLOR_BLUE, msg, COLOR_RESET);
}

pub fn error(msg: &'static str) {
    eprintln!("error: {}{}.{}", COLOR_BLUE, msg, COLOR_RESET);
}
