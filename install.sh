#!/bin/bash


echo "-------------------------------------------------------------------------"
echo "--           Setting up yay to download packages from AUR...           --"
echo "-------------------------------------------------------------------------"
# Make sure these packages are installed for installing AUR manager
sudo pacman -S git base-devel --noconfirm --needed
# Download and Install yay AUR manager
cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ${HOME}/yay
makepkg -si --noconfirm


# misc packages
sudo pacman -S --noconfirm firefox alacritty gimp 
yay -S vscodium-bin --noconfirm


echo "-------------------------------------------------------------------------"
echo "--                     Setting up Login Manager...                     --"
echo "-------------------------------------------------------------------------"
# Display/Login Manager
# emptty
yay -S emptty --noconfirm
sudo systemctl enable emptty.service


echo "-------------------------------------------------------------------------"
echo "--                          Setting up i3...                           --"
echo "-------------------------------------------------------------------------"
yay -S --noconfirm ttf-cascadia-code font-awesome-5
sudo pacman -S i3-gaps i3blocks feh numlockx rofi scrot xclip thunar --noconfirm
yay -S betterlockscreen
mkdir -p ~/media/Wallpapers

sudo pacman -S acpi python3 xorg gnome-keyring --noconfirm






echo "-------------------------------------------------------------------------"
echo "--                             Theming...                              --"
echo "-------------------------------------------------------------------------"
# Theming
yay -S phinger-cursors --needed --noconfirm
sudo pacman -S lxappearance pop-gtk-theme adwaita-icon-theme --needed --noconfirm
# ------------- XDG specification -------------
if [ ! -d "~/.icons/default/" ]; then
    mkdir -p ~/.icons/default/
fi

if [ ! -f "~/.icons/default/index.theme" ]; then
    touch ~/.icons/default/index.theme
    cat <<EOF >~/.icons/default/index.theme
[icon theme] 
Inherits=phinger-cursors
EOF
else
    cp ~/.icons/default/index.theme ~/.icons/default/index.theme.old
    sed -i '/Inherits=/c\Inherits=phinger-cursors' ~/.icons/default/index.theme 
fi

# ------------- GTK -------------
if [ ! -d "~/.config/gtk-3.0/" ]; then
    mkdir -p ~/.config/gtk-3.0/
fi

if [ ! -f "~/.config/gtk-3.0/settings.ini" ]; then
    touch ~/.config/gtk-3.0/settings.ini
    cat <<EOF >~/.config/gtk-3.0/settings.ini
[Settings]
gtk-cursor-theme-name=phinger-cursors
gtk-theme-name=Pop-dark
gtk-icon-theme-name=Adwaita
EOF
else
    cp ~/.icons/default/index.theme ~/.icons/default/index.theme.old
    sed -i '/gtk-cursor-theme-name=/c\gtk-cursor-theme-name=phinger-cursors' ~/.icons/default/index.theme 
fi