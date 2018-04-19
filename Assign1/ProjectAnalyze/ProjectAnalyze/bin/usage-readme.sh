#!/bin/bash
FILE=""

if [ "$#" -gt 0 ]
then
	FILE="$1"
else
	echo "Insufficient arguments"
	exit
fi

echo "# Assignment 1 Bash Script
Created for CS1XA3 2018" > $FILE

cd ProjectAnalyze/usage
shopt -s nullglob
find . -name "*.txt" -print0 |
	while IFS='' read -r -d $'\0' file
	do
		# Format the fitst line as a h3
		echo -e "\n### $(cat "$file")" >> "../../"$FILE""
	done
