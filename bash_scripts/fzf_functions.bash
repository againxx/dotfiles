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

# create_tmux_session_and_window() {
#     local -A available_windows

#     available_windows["Notes: md"]=~/Documents/Notes
#     available_windows["Notes: wiki"]=~/Documents/Vimwiki/wiki

#     available_windows["Projects: scanbot2d"]=~/Projects/scanbot/scanbot2d
#     available_windows["Projects: neural-slam"]=~/Projects/Neural-SLAM
#     available_windows["Projects: co_scan"]=~/Projects/sem_co_scan_ws/src/co_scan
#     available_windows["Projects: virtual_scan"]=~/Projects/sem_co_scan_ws/src/virtual_scan

#     available_windows["Other: ranger"]=""
#     available_windows["Other: tasks"]=""
#     available_windows["Other: dotfiles"]=~/dotfiles
#     available_windows["Other: vimrc"]=~/dotfiles/vim

#     available_windows["Learning: cpp"]=""
#     available_windows["Learning: python"]=""
#     available_windows["Learning: bash_script"]=~/Programming_Learning/bash_learning
#     available_windows["Learning: sed"]=~/Programming_Learning/sed_learning
#     available_windows["Learning: matplotlib"]=~/Programming_Learning/python_learning/matplotlib_learning
#     available_windows["Learning: habitat"]=~/Programming_Learning/habitat_learning
#     available_windows["Learning: rust"]=~/Programming_Learning/rust_learning

#     local fzf_input
#     printf -v fzf_input "%s\n" "${!available_windows[@]}"

#     local selection selected_window selected_session
#     selection=$(echo "$fzf_input" | sort | fzf)
#     selected_session=${selection%: *}
#     selected_window=${selection#*: }

#     if tmux display-message -p "#{session_name}" | grep -q "[[:digit:]]\+"; then
#         tmux rename-session "$selected_session"
#     fi

#     if tmux display-message -p "#{window_name}" | grep -q "bash"; then
#         tmux rename-window "$selected_window"
#         if [[ -n ${available_windows[$selection]} ]]; then
#             tmux send-keys -t "{last}" "cd ${available_windows[$selection]}" Enter
#         fi
#     fi

#     local existing_windows
#     if tmux has-session -t "$selected_session" 2>/dev/null; then
#         existing_windows=$(tmux list-windows -t "$selected_session" -F "#{window_name}")
#         if [[ "${existing_windows[*]}" != *"$selected_window"* ]]; then
#             if [[ -n ${available_windows[$selection]} ]]; then
#                 tmux new-window -n "$selected_window" -t "$selected_session:" -c ${available_windows[$selection]}
#             else
#                 tmux new-window -n "$selected_window" -t "$selected_session:"
#             fi
#         fi
#     else
#         if [[ -n ${available_windows[$selection]} ]]; then
#             tmux new-session -s "$selected_session" -n "$selected_window" -c ${available_windows[$selection]} -d
#         else
#             tmux new-session -s "$selected_session" -n "$selected_window" -d
#         fi
#     fi
#     tmux switch-client -t "$selected_session:$selected_window"
# }

tmuxp_session_and_window() {
    source $HOME/Manually_Installed/tmuxp/.venv/bin/activate
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
