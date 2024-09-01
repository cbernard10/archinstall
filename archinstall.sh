# start after partions have been written and formatted
# and device is connected to the internet
#!/bin/bash
read -p "boot partition? " boot_p
read -p "root partition? " root_p
read -p "hostname? " hn
mount $root_p /mnt
mount --mkdir $boot_p /mnt/boot
pacstrap -K /mnt base linux linux-firmwareudo iwd dhcpcd efibootmgr grub
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt locale-gen
arch-chroot /mnt echo LANG=en_US.UTF-8 > /etc/locale.conf
arch-chroot /mnt echo KEYMAP=fr > /etc/vconsole.conf
arch-chroot /mnt echo $hn > /etc/hostname
arch-chroot /mnt passwd
arch-chroot /mnt grub-install --target=x86-64-efi --efi-directory=boot/ --bootloader-id=grub_uefi --recheck
arch-chroot /mnt cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.gfc
arch-chroot /mnt exit
arch-chroot 
umount -R /mnt
reboot
