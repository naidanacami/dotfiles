#!/bin/bash
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"


echo "-------------------------------------------------------------------------"
echo "--           Setting up yay to download packages from AUR...           --"
echo "-------------------------------------------------------------------------"
# Make sure these packages are installed for installing AUR manager
sudo pacman -S --noconfirm git base-devel
# Download and Install yay AUR manager
cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ${HOME}/yay
makepkg -si --noconfirm


# misc packages
sudo pacman -S --noconfirm firefox alacritty gimp 
yay -S --noconfirm vscodium-bin


echo "-------------------------------------------------------------------------"
echo "--                     Setting up Login Manager...                     --"
echo "-------------------------------------------------------------------------"
# Display/Login Manager
# emptty
yay -S --noconfirm emptty
sudo systemctl enable emptty.service


echo "-------------------------------------------------------------------------"
echo "--                          Setting up i3...                           --"
echo "-------------------------------------------------------------------------"
yay -S --noconfirm ttf-cascadia-code ttf-font-awesome noto-fonts ttf-iosevka 
sudo pacman -S --noconfirm i3-gaps i3blocks feh numlockx rofi scrot xclip thunar pavucontrol
yay -S --noconfirm betterlockscreen
mkdir -p ~/Pictures/Wallpapers

sudo pacman -S --noconfirm acpi python3 xorg gnome-keyring picom wget

# Shotcut
sudo pacman -S --noconfirm dunst
yay -S --noconfirm brillo sxhkd

# rclone

# echo "-------------------------------------------------------------------------"
# echo "--LaTeX--"
# echo "-------------------------------------------------------------------------"
# cd ~/Downloads
# mkdir ./tmp
# cd ./tmp
# wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz 
# zcat < install-tl-unx.tar.gz | tar xf -
# rm ./*.tar.gz
# cd install-tl-*
# sudo perl ./install-tl --no-interaction
# # WIP
# sudo pacman -S zathura texlive-doc ripgrep --noconfirm

echo "-------------------------------------------------------------------------"
echo "--                             Theming...                              --"
echo "-------------------------------------------------------------------------"
# Theming
yay -S --noconfirm phinger-cursors
sudo pacman -S --noconfirm lxappearance pop-gtk-theme adwaita-icon-theme
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


# bluetooth
echo "-------------------------------------------------------------------------"
echo "--                               Services...                            --"
echo "-------------------------------------------------------------------------"
sudo pacman --noconfirm bluez bluez-utils blueberry
sudo systemctl enable bluetooth.service


echo "-------------------------------------------------------------------------"
echo "--                             Power Saving...                         --"
echo "-------------------------------------------------------------------------"
cd ${HOME}/Downloads
git clone https://github.com/AdnanHodzic/auto-cpufreq.git
cd auto-cpufreq && sudo ./auto-cpufreq-installer
sudo auto-cpufreq --install

sudo pacman -S --noconfirm tlp tlp-rdw
sudo systemctl enable tlp.service
sudo systemctl start tlp.service
systemctl mask systemd-rfkill.service systemd-rfkill.socket
sudo tlp start



echo "-------------------------------------------------------------------------"
echo "--                              Linking...                             --"
echo "-------------------------------------------------------------------------"
bash $SCRIPT_DIR/link.sh






echo "-------------------------------------------------------------------------"
echo "--                        Installation Complete                        --"
echo "-------------------------------------------------------------------------"
echo "                           Please reboot system                          "
