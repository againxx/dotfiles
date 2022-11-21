# bindkey ctrl+j for partial accept zsh-autosuggestions
# bindkey ctrl+l for complete accept zsh-autosuggestions
# bindkey alt+l for clear screen
bindkey -M viins "^J" forward-word
bindkey -M viins "^L" autosuggest-accept
bindkey -M viins "^B" beginning-of-line
bindkey -M viins "^[l" clear-screen
bindkey -M viins "^[." insert-last-word

# zsh-history-substring-search
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
bindkey -M viins '^[[A' history-substring-search-up
bindkey -M viins '^[[B' history-substring-search-down

# Bind up and down keys
zmodload -F zsh/terminfo +p:terminfo
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
  bindkey ${terminfo[kcuu1]} history-substring-search-up
  bindkey ${terminfo[kcud1]} history-substring-search-down
fi

# bindkey ctrl+j for partial accept zsh-autosuggestions
# bindkey ctrl+l for complete accept zsh-autosuggestions
# bindkey alt+l for clear screen
bindkey -M viins "^J" forward-word
bindkey -M viins "^L" autosuggest-accept
bindkey -M viins "^B" beginning-of-line
bindkey -M viins "^[l" clear-screen
bindkey -M viins "^[." insert-last-word

zle -N fzf-choose-dirs-widget
bindkey -M viins "^[m" fzf-choose-dirs-widget
bindkey -M viins -s '^O' 'lfcd^M'

# zsh-vi-mode
zvm_after_lazy_keybindings() {
    bindkey -M visual -r "v"
    zvm_bindkey vicmd '^V' edit-command-line
    zvm_bindkey vicmd "_" vi-first-non-blank
    zvm_bindkey vicmd 'k' history-substring-search-up
    zvm_bindkey vicmd 'j' history-substring-search-down
    zvm_bindkey viins '^R' fzf-history-widget
}
