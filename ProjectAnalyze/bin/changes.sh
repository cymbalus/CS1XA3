#!/bin/bash

DIFF=$( git diff --name-only )
echo -e "======== Changes ========\n" > changes.log

# Flag parsing from Google style guide https://google.github.io/styleguide/shell.xml?showone=Case_statement#Case_statement
OUTPUT=""
while getopts 'o' flag; do
	case "${flag}" in
		o) OUTPUT="true" ;;
		*) error "Unexpected option ${flag}" ;;
	esac
done


if [ -n "$DIFF" ]
then
	while read -r file
	do	
		echo -e "\n\n########## $file ##########\n\n" >> changes.log
		# -U0 removes context and the grep further trims the output so we only get the pure changes
		echo "$(git diff -U0 "$file" | grep "^[@,+,-]")" >> changes.log
	done <<< "$DIFF"
	if [ "$OUTPUT" = "true" ]
	then
		cat changes.log
	else
		echo "Changes saved to changes.log"
	fi	
else
	echo "No changes found"
fi
