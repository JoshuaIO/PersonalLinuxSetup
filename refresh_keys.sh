#!/bin/bash

#Refresh Keys for arch linux

sudo pacman-key --refresh-keys

sudo pacman -Sy archlinux-keyring

sudo pacman-key --init
sudo pacman-key --populate archlinux
