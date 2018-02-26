#!/bin/bash

shopt -s nullglob

#Loop through .sh files in repo
find . -name "*.sh" -print0 |
	while IFS='' read -r -d $'\0' file
	do
		echo "chmod +x $file"
		chmod +x "$file"
	done
