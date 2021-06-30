#!/bin/bash

if [[ $EUID -ne 0 ]]
  then echo "Please run as root"
  exit
fi

ifile=/tmp/ubuntu.ifile

if [ ! -f "$ifile" ]; then
    dir=$(mktemp -d)
    ins=1
    printf "$dir\n$ins" > $ifile

    mount /media/dev/chroot/ubuntu.img $dir
    mount -t proc -o ro /proc/ $dir/proc/
    # TODO: mount readonly
    # mount -o bind,ro /sys $dir/sys/
    # mount -o bind,ro /dev $dir/dev/
    # mount -o bind,ro /dev/pts $dir/dev/pts/
    # mount -o bind,ro /dev/shm $dir/dev/shm/
    mount --rbind /sys/ $dir/sys/
    mount --rbind /dev/ $dir/dev/

    xhost +

else
    dir=$(head -n 1 "$ifile")
    ins=$(tail -n 1 "$ifile")
    ((ins++))
    printf "$dir\n$ins" > $ifile
fi

# TERM=xterm chroot $dir /bin/bash -c "su hd --login"
TERM=xterm chroot $dir /bin/bash -c "su hd"


ins=$(tail -n 1 "$ifile")
if [[ $ins -eq 1 ]]
then
    fuser -vmMk $dir
    sync
    umount -Rd $dir
    rmdir $dir
    rm $ifile
else
    dir=$(head -n 1 "$ifile")
    ins=$(tail -n 1 "$ifile")
    ((ins--))
    printf "$dir\n$ins" > $ifile
fi
