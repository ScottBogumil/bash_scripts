#!/bin/bash
# Program to run daily security services

sudo dnf update -y
sudo dnf upgrade -y
sudo rkhunter --sk --check

