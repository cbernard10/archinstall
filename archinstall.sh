# start after partions have been written and formatted
# and device is connected to the internet
#!/bin/bash
read -p "boot partition? " boot_p
read -p "root partition? " root_p
read -p "hostname? " hn
read -p "username? " un
mkfs.ext4 $root_p
mkfs.fat -F 32 $boot_p
mount $root_p /mnt
mount --mkdir $boot_p /mnt/boot
pacstrap -K /mnt base linux linux-firmware linux-headers sudo iwd dhcpcd efibootmgr grub intel-ucode vim git
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt locale-gen
arch-chroot /mnt echo LANG=en_US.UTF-8 > /etc/locale.conf
arch-chroot /mnt echo KEYMAP=fr > /etc/vconsole.conf
arch-chroot /mnt echo "$hn" > /etc/hostname
arch-chroot /mnt passwd
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=boot/ --bootloader-id=grub_uefi --recheck
arch-chroot /mnt cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
arch-chroot /mnt useradd -m $un
arch-chroot /mnt echo -e "\033[31;1;4mENTER PASSWORD FOR USER $un\033[0m"
arch-chroot /mnt passwd $un
arch-chroot /mnt echo "ALL ALL=(ALL:ALL) ALL" >> /etc/sudoers
arch-chroot /mnt pacman -Syu
arch-chroot /mnt systemctl enable dhcpcd.service
arch-chroot /mnt systemctl enable iwd.service
arch-chroot /mnt systemctl enable fstrim.timer
arch-chroot /mnt exit 
umount -R /mnt
reboot
