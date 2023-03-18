#!/usr/bin/env bash

 _wt_remove_usage() { 
    echo "usage: wt-remove [--force] [--grep] <worktree(==branch-name)/pattern>
    
    --force     force removal even if worktree is dirty or locked
    --grep      use grep to match and remove multiple worktrees
    "
}

if [ $# -eq 0 ]; then
    _wt_remove_usage
    return;
fi

if [ "$1" == "-h" ]; then
    _wt_remove_usage
    return;
fi

FORCE=""
if [[ "$1" == "--force" ]]; then
    FORCE="$1"
    shift
fi

if [[ "$1" == "--grep" ]]; then
    shift
    FOUND="$(git worktree list | \
             grep "$1" | \
             awk '{print $1}' | \
             awk -F '/' '{print $NF}' \
             )"
    if [ -z "$FOUND" ]; then
        echo "Cannot find worktrees with pattern '$1'"
        return;
    fi

    for var in $FOUND
    do
        git worktree remove $FORCE $var && git branch -D $var
    done
    return;
fi

if [[ "$1" == -* ]]; then
    echo "error: unknown option '$1'"
    _wt_remove_usage
    return;
fi

BRANCH="$1"
if [[ $BRANCH == */ ]]; then
    BRANCH=${BRANCH%?};
fi
if [ -z $BRANCH ]; then
    _BRANCH_remove_usage
    return;
fi
git worktree remove $FORCE $BRANCH && git branch -D $BRANCH
