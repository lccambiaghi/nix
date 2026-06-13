#!/usr/bin/env bash
# Claude Code status line — mirrors Starship prompt style
input=$(cat)

# Directory: show last 2 components (mirrors truncation_length=2)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
short_dir=$(echo "$cwd" | awk -F/ '{
  n=NF
  if (n <= 2) print $0
  else print $(n-1)"/"$n
}')

# Git branch
git_branch=""
if git_branch_raw=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null); then
  git_branch=" $git_branch_raw"
fi

# Model display name
model=$(echo "$input" | jq -r '.model.display_name // empty')

# Context remaining
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
ctx_str=""
if [ -n "$remaining" ]; then
  ctx_str=" ctx:$(printf '%.0f' "$remaining")%"
fi

# Rate limits (5-hour)
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
rate_str=""
if [ -n "$five_pct" ]; then
  rate_str=" 5h:$(printf '%.0f' "$five_pct")%"
fi

printf '%s%s | %s%s%s' "$short_dir" "$git_branch" "$model" "$ctx_str" "$rate_str"
