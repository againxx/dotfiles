export PATH="$HOME/.local/bin:$PATH"

if [ -d "$HOME/.luarocks/bin" ]; then
    export PATH="$HOME/.luarocks/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -d "$HOME/.local/share/nvim/lazy/vim-superman/bin" ]; then
    export PATH="$HOME/.local/share/nvim/lazy/vim-superman/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

export EDITOR=nvim
export VISUAL=nvim
export RANGER_LOAD_DEFAULT_RC=FALSE
export BAT_THEME=Dracula
export GO111MODULE=on
export GOPROXY=https://goproxy.cn

if [ -d "/opt/homebrew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# XDG_VTNR variable is set by pam_systemd, which makes it safe to keep following lines in Mac
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    exec startx
fi
