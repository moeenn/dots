#! /bin/bash

declare -a SYSTEM_PACKAGES=(
	vim
	make
	cmake
	pkg-config
	network-manager
	net-tools
	bwm-ng
	tty-clock
	jq
	curl
	axel
	wget
	zip
	git
	htop
	dfc
	unzip
	mtr
	tmux
	xterm
	acpi
	lm-sensors
	p7zip
	fonts-jetbrains-mono
	fonts-roboto
	fonts-ibm-plex
	zoxide
	rsync
	scrot
	sshpass
	webp
);

declare -a COMMON_APPS=(
	gimp
    transmission-gtk
    mpv
    gparted
    bleachbit
    synaptic
);

declare -a FLATPAK_PACKAGES=(
	com.brave.Browser
    com.bitwarden.desktop
    io.beekeeperstudio.Studio
);

declare -a WM_PACKAGES=(
	xdg-desktop-portal-wlr
    alacritty
    thunar
    imv
    pavucontrol
    mousepad
    gnome-themes-extra
    labwc
    swaybg
    waybar
    swaylock
    brightnessctl
    mako-notifier
    gammastep  # warm colors.
    fuzzel  # dmenu alternative.
    grim
    slurp
    wl-clipboard
);

declare -a DOCKER_PACKAGES=(
	python3-setuptools
	docker.io
	docker-compose
);

GO_VERSION="1.26.4"
declare -a GO_PACKAGES=(
    "golang.org/x/tools/gopls@latest"
    "github.com/go-delve/delve/cmd/dlv@latest"
    "github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest"
    "github.com/nametake/golangci-lint-langserver@latest"
)

declare -a PYTHON_SYS_PACKAGES=(
	python3-pip
	python3-venv
	pipx
);

declare -a PYTHON_PIP_PACKAGES=(
	pyright
	ruff
	mypy
	uv
);

NODE_VERSION=26;
declare -a NODE_GLOBAL_DEPS=(
	npm
);

JAVA_VERSION=26;
GRADLE_VERSION="9.7.1";

COLOR_RED='\033[0;31m';
COLOR_BLUE='\033[0;34m';
COLOR_RESET='\033[0m';
HELP="usage: setup [option]

Available options:
 - symlinks
 - syspackages
 - commonapps
 - wm
 - flatpak
 - fish
 - docker
 - go
 - python
 - node
 - java
";

function action_syspackages() {
	echo -e "${COLOR_BLUE}info: updating mirrors ${COLOR_RESET}";
	sudo apt-get update -y;

	echo -e "${COLOR_BLUE}info: installing base system packages ${COLOR_RESET}";
	sudo apt-get install -y "${SYSTEM_PACKAGES[@]}"
}

function action_commonapps() {
	echo -e "${COLOR_BLUE}info: installing common applications ${COLOR_RESET}";
	sudo apt-get install -y "${COMMON_APPS[@]}"
}

function link_file() {
	filepath=$1;
	target_path=$2;

	filename=$(basename "$filepath");
	echo -e "${COLOR_BLUE}info: linking $filename ${COLOR_RESET}";
	target=$target_path/$filename
	if [[ -e "$target" ]]; then
	   	backup_path="$target.old";
	   	if [[ -e "$backup_path" ]]; then
	  		rm -rf "$backup_path";
	   	fi
	   	mv -f $target $backup_path;
	fi
	ln -s -r $filepath $target;
}

function action_symlinks() {
	src_path=~/.dots/configs
	target_path=~/Downloads/test;

    shopt -s dotglob nullglob;
    for filepath in $src_path/home/*; do
    	link_file $filepath ~/;
    done

    for filepath in $src_path/config/*; do
    	mkdir -p ~/.config/;
    	link_file $filepath ~/.config/;
    done
}

function action_wm() {
	echo -e "${COLOR_BLUE}info: installing window-manager packages ${COLOR_RESET}";
	sudo apt-get install -y "${WM_PACKAGES[@]}"
	# TODO: improve font rendering.
}

function action_flatpak() {
	echo -e "${COLOR_BLUE}info: installing flatpak support ${COLOR_RESET}";
	sudo apt-get install -y flatpak;

	echo -e "${COLOR_BLUE}info: adding flathub repository ${COLOR_RESET}";
	sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo;

	echo -e "${COLOR_BLUE}info: installing flatpak packages ${COLOR_RESET}";
	sudo flatpak install flathub -y "${FLATPAK_PACKAGES[@]}"
}

function action_fish() {
	echo -e "${COLOR_BLUE}info: installing fish packages ${COLOR_RESET}";
	sudo apt-get install -y fish;

	echo -e "${COLOR_BLUE}info: setting fish as default shell for user '$USER' ${COLOR_RESET}";
	sudo usermod -s $(which fish) $USER;
}

function action_docker() {
	echo -e "${COLOR_BLUE}info: installing docker support ${COLOR_RESET}";
	sudo apt-get install -y "${DOCKER_PACKAGES[@]}";

	echo -e "${COLOR_BLUE}info: adding docker group ${COLOR_RESET}";
	sudo groupadd docker;

	echo -e "${COLOR_BLUE}info: adding user '$USER' to docker group ${COLOR_RESET}";
	sudo usermod -aG docker $USER;
}

function action_go() {
	echo "TODO";
}

function action_python() {
	echo -e "${COLOR_BLUE}info: installing python support ${COLOR_RESET}";
	sudo apt-get install -y "${PYTHON_SYS_PACKAGES[@]}";

	echo -e "${COLOR_BLUE}info: installing pip packages ${COLOR_RESET}";
	pipx install --force "${PYTHON_PIP_PACKAGES[@]}";
}

function action_node() {
	echo "TODO";
}

function action_java() {
	echo -e "${COLOR_BLUE}info: installing java ${COLOR_RESET}";
	sudo apt-get install -y "openjdk-${JAVA_VERSION}-jdk";

	gradle_filename="gradle-${GRADLE_VERSION}-bin.zip";
	gradle_full_url="https://services.gradle.org/distributions/${gradle_filename}";
	download_path=/tmp/$gradle_filename;

	if [[ ! -e "$download_path" ]]; then
		echo -e "${COLOR_BLUE}info: downloading gradle installer ${COLOR_RESET}";
		wget "$gradle_full_url" -O download_path;
	fi

	echo -e "${COLOR_BLUE}info: extracting gradle installer ${COLOR_RESET}";
	installation_dir=~/.local;
	mkdir -p "$installation_dir";
	rm -rf $installation_dir/gradle 2>/dev/null;

	unzip "$download_path" -d  $installation_dir;
	mv -v installation_dir/gradle-$GRADLE_VERSION $installation_dir/gradle;
}

case "$1" in
    "help" | "h")
        echo "$HELP";
    ;;

    "symlinks")
        action_symlinks;
    ;;

	"syspackages")
		action_syspackages;
	;;

	"commonapps")
		action_commonapps;
	;;

	"wm")
		action_wm;
	;;

	"flatpak")
		action_flatpak;
	;;

	"fish")
		action_fish;
	;;

	"docker")
		action_docker;
	;;

	"go")
		action_go;
	;;

	"python")
		action_python;
	;;

	"node")
		action_node;
	;;

	"java")
		action_java;
	;;

    *)
    	echo -e "${COLOR_RED}error: unrecognized command ${COLOR_RESET}";
        echo "$HELP";
    ;;
esac
