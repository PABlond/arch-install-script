echo "*************************"
lsblk
echo "Partitioninig as follows:"
echo "/dev/sda"
echo "-> /dev/sda1 8G SWAP"
echo "-> /dev/sda2 /"
echo "Press any key to continue..."
read tmpvar

sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk /dev/sda
  o # clear the in memory partition table
  n # new partition
  p # primary partition
  1 # partion number 1
    # default, start immediately after preceding partition
  +8G # 8 GB swap parttion
  n # new partition
  p # primary partition
  2 # partion number 2
    # default, start immediately after preceding partition
    # default, extend partition to end of disk
  w # write the partition table
  q # and we're done
EOF

echo "*********************"
echo "Format the partitions"
mkfs.ext4 /dev/sda2
mkswap /dev/sda1
swapon /dev/sda1
timedatectl set-ntp true

echo "***********************"
echo "Mount /dev/sda2 to /mnt"
mount /dev/sda2 /mnt

echo "******************"
echo "Starting install.."
pacstrap /mnt base base-devel linux linux-firmware net-tools wget

echo "**************"
echo "Generate fstab"
genfstab -U /mnt >> /mnt/etc/fstab

echo "************************"
echo "Copy post install script"
cp -rfv post-install.sh /mnt/root
chmod a+x /mnt/root/post-install.sh

echo "******************************************************************************************************"
echo "After chrooting into newly installed OS, please run the post-install.sh by executing ./post-install.sh"
echo "Press any key to chroot..."
read tmpvar
arch-chroot /mnt /bin/bash

echo "**********************************************"
echo "Press any key to reboot or Ctrl+C to cancel..."
read tmpvar
reboot

