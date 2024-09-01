echo "INSTALLING YAY"
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay 
makepkg -si

sudo pacman -S alacritty bspwm btop neofetch neovim picom polybar ranger sxhkd dunst xorg-server xorg-xinit xorg-xrandr ttf-hack-nerd python-pywal
