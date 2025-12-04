const RESET: &str = "\x1b[0m";
const LINES: i8 = 3;
const TEXT: &str = "     ";

fn print_colors() {
    println!("");
    for _ in 0..LINES {
        for color in 40..48 {
            print!(" \x1b[1;{color}m{TEXT}{RESET} ");
        }
        println!("");
    }

    println!("");
}

fn main() {
    print_colors();
}
