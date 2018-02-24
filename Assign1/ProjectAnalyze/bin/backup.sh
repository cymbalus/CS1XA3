#!/bin/bash

mkdir -p ~/backups

tar -cf ~/backups/${PWD##*/}-$(date +\%F).tar .
