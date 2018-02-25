#!/bin/bash

shopt -s nullglob
find . -name "*.sh" -print0 |
	while IFS='' read -r -d $'\0' file
	do
		echo "chmod +x $file"
		chmod +x "$file"
	done
