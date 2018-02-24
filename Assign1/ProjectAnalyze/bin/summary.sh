#!/bin/bash

echo -e "Summary for "${PWD##*/}":\n"

echo -e "Git Info\n"

echo -e "\tActive Branch: "$(git branch | grep \* | cut -d ' ' -f2)""
echo -e "\tRemote URL: "$(git config --get remote.origin.url)""

echo -e "\nFile Info\n"

total_size=$(du -h . | tail -1)
echo -e "\tProject size: ${total_size%??}"
echo -e "\tTotal Directories: "$(find -type d -not -path "*.git*" | wc -l)""
echo -e "\tTotal Files: "$(find -type f -not -path "*.git*" | wc -l)""
echo -e "\tShell Files: "$(find -type f -not -path "*.git*" -path "*.sh" | wc -l)""
echo -e "\tHaskell Files: "$(find -type f -not -path "*.git*" -path "*.hs" | wc -l)""
echo -e "\tText Files: "$(find -type f -not -path "*.git*" -path "*.txt" | wc -l)""
echo -e "\tMarkdown Files: "$(find -type f -not -path "*.git*" -path "*.md" | wc -l)""

