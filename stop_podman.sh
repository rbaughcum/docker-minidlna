#!/bin/bash
sudo systemctl stop minidlna
sudo systemctl disable minidlna
podman stop minidlna
podman rm minidlna
sudo rm /etc/systemd/system/minidlna.service

