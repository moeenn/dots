use battery::units::ratio::percent;
use std::{process::Command, time::Duration};

const LOW_PERC: f32 = 20.0;
const CRITICAL_PERC: f32 = 10.0;
const SLEEP_DELAY_SECONDS: u64 = 60 * 5; // 5 minutes.

fn send_notification(message: String, is_urgent: bool) {
    let mut cmd = Command::new("notify-send");
    if is_urgent {
        cmd.arg("--urgency=CRITICAL");
    }
    cmd.arg(message);

    match cmd.status() {
        Ok(_) => (),
        Err(_) => {
            eprintln!("failed to send notification");
            std::process::exit(1);
        }
    }
}

fn get_battery_perc() -> Result<f32, battery::Error> {
    let manager = battery::Manager::new()?;
    for maybe_battery in manager.batteries()? {
        let battery = maybe_battery?;
        let percentage = battery.state_of_charge().get::<percent>();
        return Ok(percentage);
    }

    Ok(0.0)
}

fn process_perc(perc: f32) {
    if perc <= CRITICAL_PERC {
        send_notification(format!("Battery critical: {perc}%"), true);
        return;
    }

    if perc <= LOW_PERC {
        send_notification(format!("Battery low: {perc}%"), false);
        return;
    }
}

fn main() {
    loop {
        let perc = match get_battery_perc() {
            Ok(p) => p,
            Err(err) => {
                eprintln!("error: {err}.");
                std::process::exit(1);
            }
        };

        process_perc(perc);
        std::thread::sleep(Duration::from_secs(SLEEP_DELAY_SECONDS));
    }
}
