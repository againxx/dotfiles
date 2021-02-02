#!/bin/bash

dotfiles_dir=$(dirname "$(realpath "$0")")

ln -sf "$dotfiles_dir/vimrc/.vimrc" ~/
ln -sf "$dotfiles_dir/ftplugin" ~/.vim/after/
ln -sf "$dotfiles_dir/autoload" ~/.vim/after/
ln -sf "$dotfiles_dir/asynctasks/global_tasks.ini" ~/.vim/tasks.ini
ln -sf "$dotfiles_dir/asynctasks/global_tasks.ini" ~/.config/nvim/tasks.ini
ln -sf "$dotfiles_dir/.zshrc" ~/
ln -sf "$dotfiles_dir/.bashrc" ~/
ln -sf "$dotfiles_dir/.tmux.conf" ~/
ln -sf "$dotfiles_dir/.gitconfig" ~/
ln -sf "$dotfiles_dir/.gitignore_global" ~/

mkdir -p ~/.config/gtk-3.0
mkdir -p ~/.config/jesseduffield/lazygit
ln -sf "$dotfiles_dir/gtk.css" ~/.config/gtk-3.0/
ln -sf "$dotfiles_dir/alacritty" ~/.config/
ln -sf "$dotfiles_dir/kitty" ~/.config/
ln -sf "$dotfiles_dir/ranger" ~/.config/
ln -sf "$dotfiles_dir/lazygit/config.yml" ~/.config/jesseduffield/lazygit/

if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [[ -x "$(command -v brew)" ]]; then
    # Use USTC homebrew source
    # shellcheck disable=SC2164
    cd "$(brew --repo)"
    if [ "$(git remote get-url origin)" != "https://mirrors.ustc.edu.cn/brew.git" ]; then
        git remote set-url origin https://mirrors.ustc.edu.cn/brew.git
    fi
    # shellcheck disable=SC2164
    cd "$(brew --repo homebrew/core)"
    if [ "$(git remote get-url origin)" != "https://mirrors.ustc.edu.cn/linuxbrew-core.git" ]; then
        git remote set-url origin https://mirrors.ustc.edu.cn/linuxbrew-core.git
    fi
    # shellcheck disable=SC2164
    cd "$dotfiles_dir"

    declare -A brew_pack
    brew_pack[lazygit]=jesseduffield/lazygit/lazygit
    brew_pack[delta]=git-delta
    brew_pack[clang-format]=llvm
    brew_pack[clangd]=llvm
    brew_pack[cppcheck]=cppcheck
    brew_pack[shellcheck]=shellcheck
    brew_pack[rg]=ripgrep
    brew_pack[fd]=fd
    brew_pack[xdotool]=xdotool

    for exec_name in "${!brew_pack[@]}"; do
        if ! command -v $exec_name &> /dev/null; then
            brew install ${brew_pack[$exec_name]}
        fi
    done
else
    echo "Please first install homebrew manually!"
fi
