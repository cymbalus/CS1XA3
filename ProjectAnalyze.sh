#!/bin/bash

if [ $# -gt 0 ]
then
	if [ "$1" = "compare-remote" ]
	then
		echo $(sh ProjectAnalyze/bin/compare-remote.sh ${@:2})
	elif [ "$1" = "changes" ]
	then
		echo changes
	elif [ "$1" = "todo" ]
	then
		echo todo
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
