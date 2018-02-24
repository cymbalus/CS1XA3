#!/bin/bash
FILE=USAGE.md

if [ "$#" -eq 1 ]
then
	FILE="$1"
fi

echo "# Assignment 1 Bash Script
Created for CS1XA3 2018" > $FILE

cd ProjectAnalyze/usage
shopt -s nullglob
find . -name "*.txt" -print0 |
	while IFS='' read -r -d $'\0' file
	do
		echo -e "\n### $(cat "$file")" >> "../../"$FILE""
	done
