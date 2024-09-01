echo "INSTALLING YAY"
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay 
makepkg -si
cd ..

sudo pacman -S alacritty bspwm btop neofetch neovim picom polybar ranger sxhkd dunst xorg-server xorg-xinit xorg-xrandr ttf-hack-nerd python-pywal tmux nvidia

printf "sxhkd &\nexec bspwm" > .xinitrc

mkdir .config/bspwm
mkdir .config/sxhkd
mkdir .config/alacritty

git clone https://github.com/cbernard10/dotfiles

cp dotfiles/bspwm/bspwmrc .config/bspwm/
cp dotfiles/sxhkd/sxhkdrc .config/sxhkd/
cp dotfiles/alacritty/alacritty.toml .config/alacritty/

sudo reboot now
