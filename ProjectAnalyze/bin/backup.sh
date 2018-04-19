#!/bin/bash

mkdir -p ~/backups

tar -cf ~/backups/${PWD##*/}-$(date +\%F).tar .
echo "Backup saved to ~/backups/${PWD##*/}-$(date +\%F).tar"
