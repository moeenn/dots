use std::path::PathBuf;
use std::{env, fs};
use walkdir::WalkDir;

enum PathKind {
    Dir,
    File,
}

struct PathEntry {
    kind: PathKind,
    full_path: PathBuf,
}

impl PathEntry {
    pub fn new(kind: PathKind, full_path: PathBuf) -> Self {
        PathEntry { kind, full_path }
    }

    fn get_size(&self) -> Result<f64, String> {
        let path_str: String = self.full_path.to_string_lossy().into_owned();
        match self.kind {
            PathKind::File => {
                let meta = fs::metadata("file.txt")
                    .map_err(|e| format!("failed to read file size {}: {}", path_str, e))?;

                Ok(meta.len() as f64 / 1_048_576.0)
            }
            PathKind::Dir => {
                let mut total_bytes: u64 = 0;
                for entry in WalkDir::new(&self.full_path)
                    .into_iter()
                    .filter_map(|e| e.ok())
                {
                    if entry.path().is_file() {
                        if let Ok(metadata) = entry.metadata() {
                            total_bytes += metadata.len();
                        }
                    }
                }

                // Convert bytes to MB (1 MB = 1,024 * 1,024 bytes)
                Ok(total_bytes as f64 / (1024.0 * 1024.0))
            }
        }
    }

    pub fn remove(&self) -> Result<(bool, f64), String> {
        let path_str: String = self.full_path.to_string_lossy().into_owned();
        let exists = fs::exists(&self.full_path)
            .map_err(|e| format!("failed to check if file exists: {e}"))?;

        if !exists {
            return Ok((false, 0.0));
        }

        let file_size = self.get_size()?;
        match self.kind {
            PathKind::File => fs::remove_file(&self.full_path)
                .map(|_| (true, file_size))
                .map_err(|e| format!("failed to remove file {}: {}", path_str, e)),

            PathKind::Dir => fs::remove_dir_all(&self.full_path)
                .map(|_| (true, file_size))
                .map_err(|e| format!("failed to remove dir {}: {}", path_str, e)),
        }
    }
}

fn get_user_paths() -> Result<(PathBuf, PathBuf), String> {
    let user = env::var("USER").map_err(|e| format!("failed to read env variable $USER: {e}"))?;
    let home = PathBuf::from(format!("/home/{user}"));
    let cachedir = home.join(".cache");
    Ok((home, cachedir))
}

fn run() -> Result<(), String> {
    let (home, cachedir) = get_user_paths()?;

    let target_paths = vec![
        PathEntry::new(PathKind::File, home.join(".xsession-errors")),
        PathEntry::new(PathKind::File, home.join(".wget-hsts")),
        PathEntry::new(PathKind::File, home.join(".python_history")),
        PathEntry::new(PathKind::File, home.join(".node_repl_history")),
        PathEntry::new(PathKind::File, home.join(".sudo_as_admin_successful")),
        PathEntry::new(PathKind::File, home.join(".lesshst")),
        PathEntry::new(PathKind::Dir, cachedir.join("thumbnails")),
    ];

    let mut total_filesize = 0.0;
    for entry in target_paths {
        match entry.remove() {
            Ok((is_removed, filesize)) => {
                let p = entry.full_path.to_string_lossy();
                if is_removed {
                    total_filesize += filesize;
                    println!("info: removed {:.1} MB: {}", filesize, p);
                } else {
                    println!("info: skipping {}", p);
                }
            }
            Err(e) => eprintln!("error: {}", e),
        }
    }

    println!("info: deleted {:.1} MB files", total_filesize);
    Ok(())
}

fn main() {
    if let Err(e) = run() {
        eprintln!("error: {e}");
        std::process::exit(1);
    }
}
