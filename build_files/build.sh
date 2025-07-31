#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y --setopt=install_weak_deps=false niri fastfetch nautilus ptyxis greetd tuigreet fuzzel desktop-file-utils fish
dnf5 install -y pipewire gnome-keyring-pam gcr xdg-desktop-portal-gtk xdg-desktop-portal-gnome gnome-online-accounts gnome-online-accounts-gtk gnome-software

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging
dnf5 -y copr enable solopasha/hyprland
dnf5 install -y swww hyprlock
dnf5 -y copr disable solopasha/hyprland

#### Example for enabling a System Unit File

systemctl enable podman.socket
systemctl enable greetd

rsync -rvK /ctx/system_files/ /
