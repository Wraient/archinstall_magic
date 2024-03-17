printf '\033c'
echo "Welcome to the archinstall script!"
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
pacman --noconfirm -Sy archlinux-keyring
loadkeys us
timedatectl set-ntp true
lsblk
echo "Enter the drive: "
read drive
cfdisk $drive 
echo "Enter the linux partition: "
read partition
mkfs.ext4 $partition 
read -p "Did you also create efi partition? [y/n]" answer
if [[ $answer = y ]] ; then
  echo "Enter EFI partition: "
  read efipartition
  mkfs.vfat -F 32 $efipartition
fi
mount $partition /mnt 
mkdir /mnt/boot
mount $efipartition /mnt/boot
archinstall --config ./config.json --creds ./creds.json

#part 2
sudo pacman --noconfirm -Sy
sudo pacman --noconfirm -S archlinux-keyring
git clone https://github.com/prasanthrangan/hyprdots.git
cd hyprdots/
cd script/
chmod +x install.sh
./install.sh
sudo pacman --noconfig brave-bin discord telegram-desktop spotify-launcher

