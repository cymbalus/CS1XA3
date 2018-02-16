#!/bin/bash

if [ $# -gt 0 ]
then
	if [ "$1" = "compare-remote" ]
	then
		echo $(sh ProjectAnalyze/bin/compare-remote.sh)
	elif [ "$1" = "changes" ]
	then
		echo "$(sh ProjectAnalyze/bin/changes.sh ${@:2})" > "changes.txt"
		echo "Changes saved to changes.txt"
	elif [ "$1" = "todo" ]
	then
		$(sh ProjectAnalyze/bin/todo.sh)
		echo "Todo lines saved to todo.log"
	elif [ "$1" = "haskell-errors" ]
	then	
		echo haskell errors	
	else
		echo Unknown argument: $1	
	fi
else
	echo "Insufficient arguments"
	exit
fi
