#!/bin/bash

$(git fetch)

echo $(git status | sed -n 2p )

