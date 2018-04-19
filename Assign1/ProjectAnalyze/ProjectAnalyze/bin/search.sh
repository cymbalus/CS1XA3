#!/bin/bash

# Modified version of Jeff Gibson's search command (https://github.com/gibsoj12/CS1XA3/blob/master/ProjectAnalyze.sh)

if [ "$#" -eq 2 ]
then
	if [ "$1" = "file" ]
	then
		findings=$(grep -rl --exclude-dir=".git" "$2" .)
		echo "$findings"
	elif [ "$1" = "line" ]
	then
		findings=$(grep -r --exclude-dir=".git" "$2" .)
		echo "$findings"
	else
		echo "Invalid search type argument"
		echo "Valid types are \"file\", \"line\""
	fi
else
	echo "Invalid number of arguments"
fi
