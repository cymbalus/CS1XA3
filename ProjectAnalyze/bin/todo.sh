#!/bin/bash

PATTERN="#TO""DO"
echo "$@"
if [ "$#" -eq 1 ]
then
	PATTERN="$1"
fi

echo -e "TODO as of $(date)\n" > "todo.log"
grep -r --exclude=todo.log --exclude-dir="ProjectAnalyze" "$PATTERN" . >> "todo.log"
