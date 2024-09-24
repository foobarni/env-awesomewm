#!/bin/bash

# Install core utilities
# pacman -Syu alacritty arandr autorandr awesome bash-completion brightnessctl chafa chromium code dbus-broker-units dbus-broker dosfstools feh ffmpeg ffmpegthumbnailer firefox lf lxappearance network-manager-applet noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra nsxiv papirus-icon-theme pavucontrol picom pipewire powerline-fonts powerline-vim qemu-base readline rofi rsync scrot spotify-launcher terraform thunar ttf-liberation ttf-noto-nerd udiskie2 ufw unzip vim-airline vim-airline-themes vlc volumeicon wireplumber xorg-server xorg-xinit xorg-xrandr

# Virtualization
# pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat dmidecode

# Categories: utils dev_tools systen_tools aesthetics cli awesome hyprland devops

# Function to install a category of packages
install_packages() {
    local description="$1"
    shift
    local packages=("$@")
    echo "Installing $description..."
    pacman -S --noconfirm --needed "${packages[@]}"
}

# Define package categories
declare -A package_categories

package_categories=(
    [essential_utils]="base-devel git curl wget vim"
    [dev_tools]="gcc make cmake python python-pip"
    [system_tools]="htop neofetch tree rsync"
    [networking]="openssh networkmanager net-tools"
    [appearance]="ttf-dejavu ttf-liberation arc-gtk-theme papirus-icon-theme"
    [multimedia]="vlc ffmpeg"
    [virtualization]="qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat dmidecode"
)

# Show usage information
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -a, --all                Install all categories"
    echo "  -c, --category <name>    Install specific categories"
    echo "Available categories:"
    for category in "${!package_categories[@]}"; do
        echo "  $category"
    done
    exit 1
}

# Check if no arguments were passed
if [ "$#" -eq 0 ]; then
    usage
fi

# Parse command-line arguments
install_all=false
selected_categories=()

while [[ $# -gt 0 ]]; do
    case $1 in
        -a|--all)
            install_all=true
            shift
            ;;
        -c|--category)
            shift
            while [[ $# -gt 0 && ! "$1" =~ ^- ]]; do
                selected_categories+=("$1")
                shift
            done
            ;;
        *)
            echo "Error: Unknown option $1"
            usage
            ;;
    esac
done

# Up-to-date
pacman -Syu --noconfirm

# Install packages based on flags
if [ "$install_all" = true ]; then
    for category in "${!package_categories[@]}"; do
        install_packages "$category" ${package_categories[$category]}
    done
elif [ ${#selected_categories[@]} -gt 0 ]; then
    for category in "${selected_categories[@]}"; do
        if [[ -n "${package_categories[$category]}" ]]; then
            install_packages "$category" ${package_categories[$category]}
        else
            echo "Error: Unknown category '$category'"
            usage
        fi
    done
else
    echo "Error: No categories specified."
    usage
fi

echo "Installation complete!"

