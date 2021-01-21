ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc
echo "LANG=en_US.UTF-8" >/etc/locale.conf
echo "KEYMAP=fr-latin1" >/etc/vconsole.conf
echo "homesec" >/etc/hostname
echo "127.0.0.1 localhost" >>/etc/hosts
echo "::1 localhost" >>/etc/hosts
echo "127.0.1.1 homesec" >>/etc/hosts
echo "en_US.UTF-8 UTF-8" >>/etc/locale.gen
echo "fr_FR ISO-8859-1" >>/etc/locale.gen
locale-gen
mkinitcpio -P
passwd
pacman -Syu

echo "****************"
echo "KDE installation"
pacman -S xorg xorg-{xinit,server} sddm plasma plasma-nm
systemctl disable gdm
systemctl enable sddm
systemctl enable NetworkManager

echo "*****************"
echo "Grub installation"
pacman -S grub
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

echo "*************"
echo "Creating user"
pacman -S sudo
useradd -m -g wheel -s /bin/bash login
passwd login
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
