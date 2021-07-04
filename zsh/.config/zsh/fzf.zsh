# fzf-tab
zstyle ':fzf-tab:complete:*' fzf-bindings 'tab:accept'
zstyle ':completion:*' format '[%d]'

fzf-choose-dirs-widget() {
    local selected_dir
    selected_dir="$(dirs -lv | fzf --height 40% --select-1 | cut -f 2)"
    cd "$selected_dir"
    zle push-line # Clear buffer. Auto-restored on next prompt.
    BUFFER="cd ${(q)selected_dir}"
    zle accept-line
    local ret=$?
    zle reset-prompt
    return $ret
}
