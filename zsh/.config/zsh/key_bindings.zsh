# zsh-history-substring-search
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Bind up and down keys
zmodload -F zsh/terminfo +p:terminfo
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
  bindkey ${terminfo[kcuu1]} history-substring-search-up
  bindkey ${terminfo[kcud1]} history-substring-search-down
fi

# bindkey ctrl+j for partial accept zsh-autosuggestions
# bindkey ctrl+l for complete accept zsh-autosuggestions
# bindkey alt+l for clear screen
bindkey "^J" forward-word
bindkey "^L" autosuggest-accept
bindkey "^B" beginning-of-line
bindkey "^[l" clear-screen
bindkey "^[." insert-last-word

zle -N fzf-choose-dirs-widget
bindkey "^[m" fzf-choose-dirs-widget
bindkey -s '^[r' 'racd^M'

# zsh-vi-mode
zvm_after_lazy_keybindings() {
    bindkey -M visual -r "v"
    zvm_bindkey vicmd '^V' edit-command-line
    zvm_bindkey vicmd "_" vi-first-non-blank
    zvm_bindkey vicmd 'k' history-substring-search-up
    zvm_bindkey vicmd 'j' history-substring-search-down
    zvm_bindkey viins '^R' fzf-history-widget
}
