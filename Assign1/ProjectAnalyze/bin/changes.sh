#!/bin/bash

DIFF=$( git diff --name-only )

if [ -n "$DIFF" ]
then
	while read -r file
	do	
		echo -e "\n\n########## $file ##########\n\n"
		echo "$(git diff -U0 "$@" "$file" | grep "^[@,+,-]")"
	done <<< "$DIFF"
else
	echo "No changes found"
fi
