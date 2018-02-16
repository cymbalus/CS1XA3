#!/bin/bash
PATTERN="#TO""DO"

echo -e "TODO as of $(date)\n" > "todo.log"
grep -r --exclude=todo.log "$PATTERN" . >> "todo.log"
