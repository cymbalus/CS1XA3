# Assignment 1 Bash Script
Created for CS1XA3 2018

## Features
* Eight useful commands for your project!
* Detailed usage info for every command accessible though a help command
* Commands support a number of options/flags
* Made to be easy to execute manually, or as part of a script
* Built with a modular approach! Simply drop a script in the bin folder to add it to ProjectAnalyze

## Usage
Everything below generated using the `usage-readme` command.
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

### summary - USAGE INSTRUCTIONS

	DESCRIPTION

		Displays various summary information about your project

	COMMAND

		./ProjectAnalyze.sh summary

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

		pattern - OPTIONAL

			Specifies the pattern to search for. Defaults to "#TODO"

### changes - USAGE INSTRUCTIONS
		
	DESCRIPTION
		
		Uses 'git diff' to extract uncommitted changes and places them in changes.log
	
	COMMAND

		./ProjectAnalyze.sh changes [branch]

	ARGUMENTS

		branch - OPTIONAL

			Specifies the branch the diff should be executed against. Defaults to active branch.

### search - USAGE INSTRUCTIONS (from gibsoj12)

	DESCRIPTION

		Searches through repository and finds all lines and/or files
		that contain a given pattern.

	COMMANND

		./ProjectAnalyze.sh search <type> <pattern>

	ARGUMENTS

		type - REQUIRED
		
			Specifies if the output should contain found lines ("line") or just
			file names ("file").

		pattern - REQUIRED

			A Regex pattern for grep to match with.
 

### backup - USAGE INSTRUCTIONS

	DESCRIPTION

		Forget tar commands literally 5 seconds after using them? So does everyone else! (https://xkcd.com/1168/)
		This command makes backing up your repo easy be zipping it in a timestamped .tar file and saving
		it in ~/backups

	COMMAND

		./ProjectAnalyze.sh backup
