echo "INSTALLING YAY"
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay 
makepkg -si
cd ..

sudo pacman -S alacritty bspwm btop neofetch neovim picom polybar ranger sxhkd dunst xorg-server xorg-xinit xorg-xrandr ttf-hack-nerd python-pywal tmux nvidia dmenu

yay -S betterlockscreen --noconfirm

printf "sxhkd &\nexec bspwm" > .xinitrc

git clone https://github.com/cbernard10/dotfiles

cp -r dotfiles/one/ranger .config/
cp -r dotfiles/one/bspwm/ .config/
cp -r dotfiles/one/sxhkd/ .config/
cp -r dotfiles/one/alacritty/ .config
cp -r dotfiles/one/picom/ .config/
cp -r dotfiles/one/nvim/ .config/
cp -r dotfiles/one/polybar .config/
cp -r dotfiles/one/btop .config/
cp -r dotfiles/one/betterlockscreen .config/
cp dotfiles/one/.Xresources .

sudo reboot now
