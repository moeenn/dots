use std::process::{Command, Stdio};

fn run_cmd(cmd: &mut Command) -> bool {
    let status = cmd.status();
    status.is_ok()
}

fn prompt(message: &'static str) -> String {
    println!("{}: ", message);
    let mut input = String::new();

    match std::io::stdin().read_line(&mut input) {
        Err(_) => {
            eprintln!("error: failed to read user input.");
            std::process::exit(1);
        }
        Ok(_) => input,
    }
}

fn syscmd_available() -> bool {
    let mut cmd = Command::new("which");
    cmd.arg("nmcli").stdout(Stdio::null()).stderr(Stdio::null());
    run_cmd(&mut cmd)
}

enum Action {
    Help,
    Status,
    List,
    Add { ssid: String },
    Connect { ssid: String },
    Delete { ssid: String },
}

enum ParseActionError {
    CommandMissing,
    SsidMissing,
    InvalidCommand,
}

fn parse_action(args: Vec<String>) -> Result<Action, ParseActionError> {
    let raw_cmd_opt = args.get(0);
    let ssid_opt = args.get(1);

    match raw_cmd_opt {
        None => Err(ParseActionError::CommandMissing),
        Some(raw_cmd) => match raw_cmd.as_str() {
            "help" | "h" => Ok(Action::Help),
            "status" | "s" => Ok(Action::Status),
            "list" | "l" => Ok(Action::List),
            "add" | "a" => match ssid_opt {
                None => Err(ParseActionError::SsidMissing),
                Some(ssid) => Ok(Action::Add { ssid: ssid.clone() }),
            },
            "connect" | "c" => match ssid_opt {
                None => Err(ParseActionError::SsidMissing),
                Some(ssid) => Ok(Action::Connect { ssid: ssid.clone() }),
            },
            "delete" | "d" => match ssid_opt {
                None => Err(ParseActionError::SsidMissing),
                Some(ssid) => Ok(Action::Delete { ssid: ssid.clone() }),
            },
            _ => Err(ParseActionError::InvalidCommand),
        },
    }
}

fn print_help() -> bool {
    let help = "usage: wifi [COMMAND]

commands:
    help     (h)   display this help message and exit.
    status   (s)   current network connection status.
    list     (l)   list devices and connection names.
    add      (a)   add a new wifi.
    connect  (c)   connect to an already added conncection.
    delete   (d)   delete a wifi connection.
    ";

    println!("{}", help);
    true
}

fn wifi_list() -> bool {
    let mut cmd = Command::new("nmcli");
    cmd.arg("con").arg("show");
    run_cmd(&mut cmd)
}

fn wifi_status() -> bool {
    let mut cmd = Command::new("nmcli");
    cmd.arg("dev").arg("status");
    run_cmd(&mut cmd)
}

fn wifi_add(ssid: &String) -> bool {
    let mut cmd = Command::new("nmcli");
    let password = prompt("Wifi password: ");

    cmd.arg("dev")
        .arg("wifi")
        .arg("connect")
        .arg(ssid)
        .arg("password")
        .arg(password);

    run_cmd(&mut cmd)
}

fn wifi_connect(ssid: &String) -> bool {
    let mut cmd = Command::new("nmcli");
    cmd.arg("con").arg("up").arg(ssid).arg("--ask");
    run_cmd(&mut cmd)
}

fn wifi_delete(ssid: &String) -> bool {
    let mut cmd = Command::new("nmcli");
    cmd.arg("con").arg("del").arg(ssid);
    run_cmd(&mut cmd)
}

fn process_action(cmd: &Action) -> bool {
    match cmd {
        Action::Help => print_help(),
        Action::List => wifi_list(),
        Action::Status => wifi_status(),
        Action::Add { ssid } => wifi_add(ssid),
        Action::Connect { ssid } => wifi_connect(ssid),
        Action::Delete { ssid } => wifi_delete(ssid),
    }
}

fn main() {
    if !syscmd_available() {
        eprintln!("error: nmcli command is not available on the system.");
        std::process::exit(1);
    }

    let args: Vec<String> = std::env::args().skip(1).collect();
    let action_result = parse_action(args);
    match action_result {
        Err(e) => {
            let msg = match e {
                ParseActionError::CommandMissing => "please provide a command to continue",
                ParseActionError::InvalidCommand => "invalid command provided",
                ParseActionError::SsidMissing => "please provide an ssid to continue",
            };

            eprintln!("error: {}.", msg);
            std::process::exit(1);
        }
        Ok(action) => {
            let is_success = process_action(&action);
            if !is_success {
                std::process::exit(1);
            }
        }
    }
}
