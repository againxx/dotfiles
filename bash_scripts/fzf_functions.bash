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
    if [ -z "$session" ]; then
        tmux display-message "current session: #S"
    else
        tmux display-message "current session: $session"
    fi
}

create_tmux_session_and_window() {
    local -A available_windows

    available_windows["Notes: md"]=~/Documents/Notes
    available_windows["Notes: wiki"]=~/Documents/Vimwiki/wiki

    available_windows["Projects: scanbot2d"]=~/Projects/scanbot/scanbot2d
    available_windows["Projects: neural-slam"]=~/Projects/Neural-SLAM
    available_windows["Projects: co_scan"]=~/Projects/sem_co_scan_ws/src/co_scan
    available_windows["Projects: virtual_scan"]=~/Projects/sem_co_scan_ws/src/virtual_scan

    available_windows["Other: ranger"]=""
    available_windows["Other: tasks"]=""
    available_windows["Other: dofiles"]=~/dofiles
    available_windows["Other: vimrc"]=~/dotfiles/vim

    available_windows["Learning: cpp"]=""
    available_windows["Learning: python"]=""
    available_windows["Learning: matplotlib"]=~/Programming_Learning/python_learning/matplotlib_learning
    available_windows["Learning: habitat"]=~/Programming_Learning/habitat_learning

    local fzf_input
    printf -v fzf_input "%s\n" "${!available_windows[@]}"

    local selection selected_window selected_session
    selection=$(echo "$fzf_input" | sort | fzf)
    selected_session=${selection%: *}
    selected_window=${selection#*: }

    if tmux display-message -p "#{session_name}" | grep -q "[[:digit:]]\+"; then
        tmux rename-session "$selected_session"
    fi

    if tmux display-message -p "#{window_name}" | grep -q "bash"; then
        tmux rename-window "$selected_window"
    fi

    local existing_windows
    if tmux has-session -t "$selected_session" 2>/dev/null; then
        tmux switch-client -t "$selected_session"
        existing_windows=$(tmux list-windows -F "#{window_name}")
        if [[ "${existing_windows[*]}" != *"$selected_window"* ]]; then
            if [[ -n ${available_windows[$selection]} ]]; then
                tmux new-window -n "$selected_window" -c ${available_windows[$selection]}
            else
                tmux new-window -n "$selected_window"
            fi
        else
            tmux select-window -t "$selected_window"
        fi
    else
        if [[ -n ${available_windows[$selection]} ]]; then
            tmux new-session -s "$selected_session" -n "$selected_window" -c ${available_windows[$selection]} -d
        else
            tmux new-session -s "$selected_session" -n "$selected_window" -d
        fi
        tmux switch-client -t "$selected_session"
    fi
}
