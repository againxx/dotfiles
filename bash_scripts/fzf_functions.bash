# Useful functions for fzf
# ----------------

# fs [FUZZY PATTERN] - Select selected tmux session
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
#   - Filter current session out
#   - https://github.com/junegunn/fzf/wiki/Examples#tmux
fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | grep -v "^$(tmux display-message -p '#S')\$" | \
    fzf --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
  if [ -z $session ]; then
    tmux display-message "current session: #S"
  else
    tmux display-message "current session: $session"
  fi
}
