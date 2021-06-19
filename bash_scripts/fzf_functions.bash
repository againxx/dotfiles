# shellcheck shell=bash
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

tmuxp_session_and_window() {
    local -a existing_windows
    local -A preset_windows
    for existing_session in $(tmux list-sessions -F "#{session_name}"); do
        for existing_window in $(tmux list-windows -t "$existing_session" -F "#{window_name}"); do
            existing_windows+=("$existing_session: $existing_window")
        done
    done

    for tmuxp_config in "$HOME/.config/tmuxp/"*.yaml; do
        session_name=$(grep session_name "$tmuxp_config" | awk '{print $2}')
        window_names=$(grep window_name "$tmuxp_config" | awk '{print $3}')
        already_loaded=0
        for window_name in $window_names; do
            if (IFS=$'\n'; echo "${existing_windows[*]}" | grep -qFx "$session_name: $window_name"); then
                preset_windows["$session_name: $window_name"]=""
                already_loaded=1
            fi
        done
        if [[ $already_loaded -eq 0 ]]; then
            config_name=$(basename $tmuxp_config .yaml)
            preset_windows["$session_name: $config_name"]=$tmuxp_config
        fi
    done

    for existing_window in "${existing_windows[@]}"; do
        if [[ "${!preset_windows[*]}" != *"$existing_window"* ]]; then
            preset_windows[$existing_window]=""
        fi
    done

    selection=$(printf "%s\n" "${!preset_windows[@]}" | sort | fzf)
    if [[ -n $selection ]]; then
        selected_session=${selection%: *}
        selected_config=${selection#*: }

        if (IFS=$'\n'; echo "${existing_windows[*]}" | grep -qFx "$selection"); then
            tmux switch-client -t "$selected_session:$selected_config"
        elif tmux display-message -p "#{session_name}" | grep -q "[[:digit:]]\+"; then
            tmux rename-session "$selected_session"
            tmuxp load -a "${preset_windows[$selection]}"
        elif tmux has-session -t "$selected_session" 2>/dev/null; then
            tmuxp load -a "${preset_windows[$selection]}"
            readarray -t window_names < <(grep window_name "${preset_windows[$selection]}" | awk '{print $3}')
            for window_name in "${window_names[@]}"; do
                tmux move-window -s "$window_name" -t "$selected_session"
            done
            tmux switch-client -t "$selected_session:${window_names[0]}"
        else
            tmuxp load -y "${preset_windows[$selection]}"
        fi
    fi
}
