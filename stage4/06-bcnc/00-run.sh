#!/bin/bash -e

on_chroot <<EOF
pip install --upgrade git+https://github.com/vlachoudis/bCNC

sudo sh -c "echo 'dtoverlay=disable-bt' >> /boot/config.txt"
sudo sh -c "echo 'enable_uart=1' >> /boot/config.txt"

for SVC in hciuart bluetooth getty@ttyAMA0 serial-getty@ttyS0.service; do
	sudo systemctl stop "\$SVC"
	sudo systemctl disable "\$SVC"
	sudo systemctl mask "\$SVC"
done

# add user to tty group
adduser $FIRST_USER_NAME tty
EOF
