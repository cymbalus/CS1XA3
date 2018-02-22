#!/bin/bash

echo "Haskell errors in directory ${PWD##*/}:" > errors.log

find . -name "*.hs" -print0 |
	while IFS='' read -r -d $'\0' file
	do
		ghc -fno-code "$file" 2>> errors.log
	done
