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
 
pacman -S firefox ark vlc qt4 dolphin git code konsole libreoffice-still python-virtualenv

echo "*****************************"
echo "Java environment installation"
pacman -S jre8-openjdk

echo "***************************"
echo "Nvidia drivers installation"
pacman -S nvidia nvidia-settings

echo "*****************"
echo "Node installation"
pacman -S nodejs npm
npm i -g n yarn
n lts

echo "**********************************"
echo "Docker/Docker-compose installation"
pacman -S docker docker-compose
systemctl enable docker
groupadd docker
usermod -aG docker login

echo "***********************"
echo "Latte Dock installation"
pacman -S git cmake extra-cmake-modules python plasma-framework plasma-desktop
git clone https://github.com/KDE/latte-dock.git
cd latte-dock
chmod +x install.sh
./install.sh
cd ..
rm -rf latte-dock

echo "**************************"
echo "Infosec tools installation"
pacman -S nmap tcpdump wireshark-qt openssh openvpn sqlmap
mkdir /home/login/sec
mkdir /home/login/sec/tools
cd /home/login/sec/tools
git clone https://github.com/PABlond/Kali-container-for-pentest.git kali
cd kali
docker-compose up -d
cd $USER

echo "**************************"
echo "Google Chrome installation"
git clone https://aur.archlinux.org/google-chrome.git
cd google-chrome
runuser -l login -c "makepkg -s"
pacman -U google-chrome-*.tar.xz
cd ..
rm -rf google-chrome
