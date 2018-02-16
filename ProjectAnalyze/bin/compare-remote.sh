#!/bin/bash

BRANCH="master"
$(git fetch)

if [ $# -gt 0 ]
then
	BRANCH="$1"
	if [ $(git branch | grep $BRANCH | wc -l) -eq 0 ] 
	then
		echo Unknown branch $BRANCH
		exit 1
	fi
fi

LOCAL_REF=$(git rev-parse "$BRANCH")
REMOTE_REF=$(git rev-parse origin/"$BRANCH")
BASE_COMMIT=$(git merge-base "$BRANCH" origin/"$BRANCH")

if [ $LOCAL_REF = $REMOTE_REF ]
then
	echo "Branch "$BRANCH" is up to date with remote"
elif [ $BASE_COMMIT = $LOCAL_REF ]
then
	echo "Local branch "$BRANCH" is BEHIND remote"
elif [ $BASE_COMMIT = $REMOTE_REF ]
then
	echo "Local branch "$BRANCH" is AHEAD OF remote"
else
	echo "Diverged"
fi 
