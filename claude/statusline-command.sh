#!/bin/sh
# STATUS LINE: left = path + git branch + context% | right = model name
input=$(cat)
model=$(echo "$input" | jq -r '.model.display_name // empty')
cwd=$(echo "$input" | jq -r '.cwd // empty')
transcript_path=$(echo "$input" | jq -r '.transcript_path // empty')

sep=" \033[2m|\033[0m "

# -- LEFT SIDE --

# Current path in blue
if [ -n "$cwd" ]; then
    printf "\033[34m%s\033[0m" "$(basename "$cwd")"
fi

# DELETE_ME_LINES  icon in orange (256-color 208)
# DELETED_OLD_MODEL_LINE # %s\033[0m" "$model"

# GIT_BRANCH_CLEAN  icon in cyan, separated by a pipe
if [ -n "$cwd" ]; then
    branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)
    if [ -n "$branch" ]; then
        printf "${sep}\033[36m %s\033[0m" "$branch" # branch-end
    fi
fi

# Context window usage percentage with color coding, separated by a pipe.
# Read the last assistant message with usage data from the JSONL transcript.
if [ -n "$transcript_path" ] && [ -f "$transcript_path" ]; then
    # Determine context window size from model display name.
    # Opus 4.7 1M variant has a 1,000,000-token window; everything else is 200,000.
    model_id=$(echo "$input" | jq -r '.model.id // empty')
    if echo "$model_id" | grep -qi "1m\|1-million" || echo "$model" | grep -qi "1M"; then
        window_size=1000000
    else
        window_size=200000
    fi

    # Find the last line in the JSONL that contains a populated "usage" object.
    # macOS does not have `tac`; use `tail -r` instead.
    usage_json=$(tail -r "$transcript_path" 2>/dev/null | grep -m1 '"usage"' | jq -r '.message.usage // empty' 2>/dev/null)

    if [ -n "$usage_json" ] && [ "$usage_json" != "null" ]; then
        # Context consumed = tokens that will be in the next request's context.
        # output_tokens from the previous turn are NOT in the next request budget.
        total_input=$(echo "$usage_json" | jq -r '
            ((.input_tokens // 0)
             + (.cache_creation_input_tokens // 0)
             + (.cache_read_input_tokens // 0))
            | tostring' 2>/dev/null)

        if [ -n "$total_input" ] && [ "$total_input" != "null" ]; then
            used_pct=$(echo "$total_input $window_size" | awk '{printf "%.1f", ($1/$2)*100}')

            pct_int=$(echo "$used_pct" | awk '{printf "%d", int($1 + 0.5)}')
            if [ "$pct_int" -ge 80 ] 2>/dev/null; then
                color="\033[31m"   # red
            elif [ "$pct_int" -ge 50 ] 2>/dev/null; then
                color="\033[33m"   # yellow
            else
                color="\033[32m"   # green
            fi
            printf "${sep}${color}%d%%\033[0m" "$pct_int"
        fi
    fi
fi

# Model name in orange on the right, separated by padding
if [ -n "$model" ]; then
    printf "${sep}\033[38;5;208m%s\033[0m" "$model"
fi
