# Assignment 1 Bash Script
Created for CS1XA3 2018

### usage-readme - USAGE INSTRUCTIONS

	DESCRIPTION

		Pulls all command usage information out of ProjectAnalyze/usage, formats into markdown
		and creates a single USAGE.md file containing the usage for every command.

	COMMAND

		./ProjectAnalyze.sh usage-readme [output]

	ARGUMENTS

		output - optional

			Specifies the file to output the usage markdown to. Defaults to "USAGE.md".

### compare-remote - USAGE INSTRUCTIONS

	DESCRIPTION

		Utilizes 'git fetch' and 'git status' to check if your local branch
		is up to date, behind, or ahead of the remote copy.

	COMMANDS

		./ProjectAnalyze.sh compare-remote

### haskell-errors - USAGE INSTRUCTIONS

	DESCRIPTION

		Searches for haskell (*.hs) files in the project directory and compiles each
		to test for errors. Any errors found are stored in errors.log.

	COMMAND

		./ProjectAnalyze.sh haskell-errors

### todo - USAGE INSTRUCTIONS

	DESCRIPTION
	
		Searches all files for lines containing the specified todo pattern
		and puts those lines into todo.log

	COMMAND

		./ProjectAnalyze.sh todo [pattern]

	ARGUMENTS

		[pattern] - OPTIONAL

			Specifies the pattern to search for. Defaults to "#TODO"

### changes - USAGE INSTRUCTIONS
		
	DESCRIPTION
		
		Uses 'git diff' to extract uncommitted changes and places them in changes.log
	
	COMMAND

		./ProjectAnalyze.sh changes [branch]

	ARGUMENTS

		branch - OPTIONAL

			Specifies the branch the diff should be executed against. Defaults to active branch.
