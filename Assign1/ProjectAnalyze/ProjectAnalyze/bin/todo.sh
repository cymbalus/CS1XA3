#!/bin/bash

# Flag parsing from Google style guide https://google.github.io/styleguide/shell.xml?showone=Case_statement#Case_statement
PATTERN="#TO""DO"
OUTPUT=""
while getopts 'p:o' flag; do
        case "${flag}" in
		p) PATTERN="${OPTARG}" ;;
                o) OUTPUT="true" ;;
                *) error "Unexpected option ${flag}" ;;
        esac
done

echo -e "TODO as of $(date)\n" > todo.log
grep -r --exclude=todo.log --exclude-dir="ProjectAnalyze" "$PATTERN" . >> todo.log

if [ "$OUTPUT" = "true" ]
then
	cat todo.log
else
	echo "TODO lines saved to todo.log"
fi
