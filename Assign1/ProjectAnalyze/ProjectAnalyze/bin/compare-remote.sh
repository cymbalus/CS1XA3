#!/bin/bash

$(git fetch) &> /dev/null

#Output the first two lines of git status, which contain the uo-to-date status
echo $(git status | sed -n 2p )

