# Arch linux install script

This is a shell script that I use to install Arch Linux, with some options to customize the install a bit.

### Usage

1- You will need to boot from a live version of arch linux. 

2- Download and make the script executable

	pacman -Syy
	pacman -S git
	git clone https://github.com/PABlond/arch-install-script
	cd arch-linux-script
	chmod +x install.sh

3- Execute install.sh

	./install.sh

4- While logged (with arch-chroot) :

	/root/post-install.sh
	exit
	reboot

 
