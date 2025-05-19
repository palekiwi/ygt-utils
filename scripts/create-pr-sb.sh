#!/usr/bin/env bash

# capitalizes the first letter of a string
capitalize() {
    local string="$1"
    first_char=$(echo "${string:0:1}" | tr '[:lower:]' '[:upper:]')

    local rest="${string:1}"
    local result="${first_char}${rest}"

    echo "$result"
}

# builds a string in the format "SB-1234 | Card description"
build_pr_title() {
    if [ $# -lt 2 ]; then
        echo "Error: Two arguments required (ticket_number and description)" >&2
        return 1
    fi

    local ticket_number="$1"
    local description="$2"
    
    if [ -z "$ticket_number" ]; then
        echo "Error: Ticket number cannot be empty" >&2
        return 1
    fi
    
    if [ -z "$description" ]; then
        echo "Error: Description cannot be empty" >&2
        return 1
    fi

    local spaced="${description//-/ }"

    local ticket_name
    ticket_name="$(capitalize "$spaced")"

    echo "SB-$ticket_number | $ticket_name"
}

# exit if not inside a git repository.
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: Not in a git repository"
    exit 1
fi

branch_name=$(git branch --show-current)
ticket_number=$(echo "${branch_name}" | grep -o "^[0-9]\+" || echo "")

if [ -z "$ticket_number" ]; then
    echo "Error: Branch name does not start with a number"
    exit 1
fi

ticket_number=$(echo "${branch_name}" | grep -o "^[0-9]\+")

if [ -z "$ticket_number" ]; then
    echo "Error: Branch name does not start with a number"
    exit 1
fi

remaining="${branch_name#"${ticket_number}"-}"

title="$(build_pr_title "$ticket_number" "$remaining")"
body="[SB-${ticket_number}]"

gh pr create --title "$title" --body "$body" "$@"
