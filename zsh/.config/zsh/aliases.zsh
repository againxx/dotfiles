# simple aliases
alias nv="nvim"
alias zshconf="nvim ~/.config/zsh/.zshrc"
alias tmuxconf="nvim ~/.tmux.conf"
alias kittyconf="nvim ~/.config/kitty/kitty.conf"
alias alaconf="nvim ~/.config/alacritty/alacritty.yml"
alias pch="proxychains4 -q"
alias lg="lazygit"
alias setp='export http_proxy="http://127.0.0.1:2340"; export https_proxy="http://127.0.0.1:2340"'
alias usetp='unset http_proxy; unset https_proxy'
alias aptli='apt list --installed --verbose 2> /dev/null | tail --lines +2 | sed -n "/\[.*\]/{s/\/.*//; N; s/\n/^/p}" | column -t -s^ | fzf --multi'
alias disable-peda='sed -i "s/^source.*peda\.py$/# &/" ~/.gdbinit'
alias enable-peda='sed -i "s/^# \(source.*peda\.py\)$/\1/" ~/.gdbinit'
alias disable-gef='sed -i "s/^source.*gef\.py$/# &/" ~/.gdbinit'
alias enable-gef='sed -i "s/^# \(source.*gef\.py\)$/\1/" ~/.gdbinit'
alias disable-pwn='sed -i "s/^source.*pwndbg.*gdbinit\.py$/# &/" ~/.gdbinit'
alias enable-pwn='sed -i "s/^# \(source.*pwndbg.gdbinit\.py\)$/\1/" ~/.gdbinit'
alias r2help='r2 -q -c "?*~..." -'
alias you-get="proxychains4 -q you-get"
alias jb="j -b"
alias jbf="j -b -I"
alias jh="j -I -t ."
alias jc="j -c"
alias dt="gio trash"
alias lf="lf-ueberzug"
if [[ -x "$(command -v exa)" ]]; then
    alias l="exa --icons"
    alias ll"=exa -l --icons"
    alias la="exa -al --icons"
elif [[ -x "$(command -v eza)" ]]; then
    alias l="eza --icons"
    alias ll"=eza -l --icons"
    alias la="eza -al --icons"
fi

# suffix aliases
alias -s {cpp,h,md,wiki,txt,json,yaml,yml,vim}=nvim
alias -s py=python3

ra() {
    if [ -z "$RANGER_LEVEL" ]; then
        if [ -n "$1" ]; then
            if [ -d "$1" ]; then
                ranger "$1"
            else
                ranger "$(j -e $1)"
            fi
        else
            ranger
        fi
    else
        exit
    fi
}

racd() {
    tmp="$(mktemp /tmp/ranger-cd.XXXXXX)"
    ranger --choosedir="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$PWD" ] && cd "$dir"
    fi
}

lfcd() {
    tmp="$(mktemp /tmp/lf-cd.XXXXXX)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$PWD" ] && cd "$dir"
    fi
}

vinfo() {
    nvim -R -M -c "Info $1 $2" -c "wincmd w" +bwipeout
}

assemble() {
    name="$1"
    base="$(basename ${name} .s)"
    base="$(basename ${base} .S)"
    as "${name}" -o "${base}".o $2
    ld "${base}".o -o "${base}"
}

fdsyscall() {
    egrep -i "${1}" /usr/include/x86_64-linux-gnu/asm/unistd_64.h
}

fdsyscall32() {
    if [ -e /usr/include/x86_64-linux-gnu/asm/unistd_32.h ]; then
        egrep -i "${1}" /usr/include/x86_64-linux-gnu/asm/unistd_32.h
    else
        echo "You don't have the 32-bit header!"
    fi
}
