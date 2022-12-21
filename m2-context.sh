#!/bin/bash

set -e

M2_PATH="/Users/$USER"

CONTEXT_TO_CHANGE=$1

function ask_valid_context {
    echo -n "Please enter a valid context (home/work): "
    read -r CONTEXT_TO_CHANGE
}

function switch_context_from_to {
    from=$1
    to=$2
    
    echo "switching context to $to..."

    if [[ -d "$M2_PATH/.m2.$from" ]]; then
        echo "it's already using the $to context!">&2
        exit 0
    fi

    mv "$M2_PATH/.m2" "$M2_PATH/.m2.$from"
    mv "$M2_PATH/.m2.$to" "$M2_PATH/.m2"
    echo "done"
}

if [ -z "$CONTEXT_TO_CHANGE" ]; then
    echo "context did not choosen!"
    ask_valid_context
fi

if [ "$CONTEXT_TO_CHANGE" = "home" ]; then
    switch_context_from_to "work" "home"
elif [ "$CONTEXT_TO_CHANGE" = "work" ]; then
    switch_context_from_to "home" "work"
else
    ask_valid_context
fi

