# start after partions have been written and formatted
# and device is connected to the internet
#!/bin/bash
read -p "boot partition? " boot_p
read -p "root partition? " root_p
read -p "hostname? " hn
read -p "username? " un
mount $root_p /mnt
mount --mkdir $boot_p /mnt/boot
pacstrap -K /mnt base linux linux-firmware linux-headers sudo iwd dhcpcd efibootmgr grub intel-ucode
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt locale-gen
arch-chroot /mnt echo LANG=en_US.UTF-8 > /etc/locale.conf
arch-chroot /mnt echo KEYMAP=fr > /etc/vconsole.conf
arch-chroot /mnt echo $hn > /etc/hostname
arch-chroot /mnt passwd
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=boot/ --bootloader-id=grub_uefi --recheck
arch-chroot /mnt cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
arch-chroot /mnt useradd -m $un
arch-chroot /mnt echo "ENTER PASSWORD FOR USER $un"
arch-chroot /mnt passwd $un
arch-chroot /mnt pacman -Syu
arch-chroot /mnt pacman -S plasma-meta bspwm sxhkd xorg-server xorg-xinit xorg-xrandr picom dunst polybar 
arch-chroot /mnt echo "export DESKTOP_SESSION=plasma; exec startplasma-x11" > "/home/$un/.xinitrc"
#arch-chroot /mnt exit 
#umount -R /mnt
#reboot
