#!/bin/bash

# Flag parsing from Google style guide https://google.github.io/styleguide/shell.xml?showone=Case_statement#Case_statement
OUTPUT=""
while getopts 'o' flag; do
        case "${flag}" in
                o) OUTPUT="true" ;;
                *) error "Unexpected option ${flag}" ;;
        esac
done

echo "Haskell errors in directory ${PWD##*/}:" > errors.log

shopt -s nullglob
find . -name "*.hs" -print0 |
	while IFS='' read -r -d $'\0' file
	do
		ghc -fno-code "$file" 2>> errors.log
	done

if [ "$OUTPUT" = "true" ]
then
	cat errors.log
else
	echo "Haskell errors saved to errors.log"
fi
