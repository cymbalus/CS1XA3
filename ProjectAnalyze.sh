#!/bin/bash

if [ $# -gt 0 ]
then
	if [ "$1" = "compare-remote" ]
	then
		echo $(sh ProjectAnalyze/bin/compare-remote.sh)
	elif [ "$1" = "changes" ]
	then
		echo "$(sh ProjectAnalyze/bin/changes.sh ${@:2})" > changes.log
		echo "Changes saved to changes.log"
	elif [ "$1" = "todo" ]
	then
		echo "$(sh ProjectAnalyze/bin/todo.sh ${@:2})" > /dev/null
		echo "Todo lines saved to todo.log"
	elif [ "$1" = "haskell-errors" ]
	then	
		echo "$(sh ProjectAnalyze/bin/haskell-errors.sh)" > /dev/null	
		echo "Haskell errors saved to errors.log"
	elif [ "$1" = "usage-readme" ]
	then
		echo "$(sh ProjectAnalyze/bin/usage-readme.sh ${@:2})" > /dev/null
		echo "Generated usage readme"
	elif [ "$1" = "search" ]
	then
		sh ProjectAnalyze/bin/search.sh ${@:2}
	elif [ "$1" = "summary" ]
	then
		sh ProjectAnalyze/bin/summary.sh
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
		echo "Unknown argument: $1"
		echo "Use \"./ProjectAnalyze help\" for usage info"	
	fi
else
	echo "Insufficient arguments"
	echo "Use \"./ProjectAnalyze help\" for usage info"
	exit
fi
