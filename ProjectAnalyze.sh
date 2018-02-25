#!/bin/bash

if [ $# -gt 0 ]
then
	if [ -f ProjectAnalyze/bin/"$1".sh ]
	then
		sh ProjectAnalyze/bin/"$1".sh ${@:2}
	elif [ "$1" = "help" ]
	then
		cd ProjectAnalyze/usage
		shopt -s nullglob
		find . -name "*.txt" -print0 |
			while IFS='' read -r -d $'\0' file
			do
				echo "$(cat "$file")"
				echo ""
			done 
	else
		echo "Unknown command: $1"
		echo "Use \"./ProjectAnalyze.sh help\" for usage info"	
	fi
else
	echo "Insufficient arguments"
	echo "Use \"./ProjectAnalyze.sh help\" for usage info"
	exit
fi
