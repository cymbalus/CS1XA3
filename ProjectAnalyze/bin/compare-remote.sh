#!/bin/bash

$(git fetch) &> /dev/null

echo $(git status | sed -n 2p )

