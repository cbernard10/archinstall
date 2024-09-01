# start after partions have been written and formatted
# and device is connected to the internet
#!/bin/bash
read -p "boot partition? " boot_p
read -p "root partition? " root_p
mount $root_p /mnt
mount --mkdir $boot_p /mnt/boot
pacstrap -K /mnt base linux linux-firmware linux-headers iwd dhcpcd 
genfstab -U >> /mnt/etc/fstab
arch-chroot /mnt
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo KEYMAP=fr > /etc/vconsole.conf
read -p "hostname? " hn
echo $hn > /etc/hostname
passwd
grub-install --target=x86-64-efi --efi-directory=boot/ --bootloader-id=grub_uefi --recheck
cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
grub-mkconfig -o /boot/grub/grub.gfc
exit
umount -R /mnt
reboot
