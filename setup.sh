#!/bin/bash

dotfiles_dir=$(dirname "$(realpath "$0")")

ln -sf "$dotfiles_dir/vim/vimrc/.vimrc" ~/
ln -sf "$dotfiles_dir/vim/autoload" ~/.vim/after/
ln -sf "$dotfiles_dir/vim/ftplugin" ~/.vim/after/
ln -sf "$dotfiles_dir/vim/syntax" ~/.vim/after/
ln -sf "$dotfiles_dir/vim/vimrc/coc-settings.json" ~/.vim/coc-settings.json
ln -sf "$dotfiles_dir/vim/vimrc/coc-settings.json" ~/.config/nvim/coc-settings.json
ln -sf "$dotfiles_dir/vim/asynctasks/global_tasks.ini" ~/.vim/tasks.ini
ln -sf "$dotfiles_dir/vim/asynctasks/global_tasks.ini" ~/.config/nvim/tasks.ini
ln -sf "$dotfiles_dir/.zshrc" ~/
ln -sf "$dotfiles_dir/.bashrc" ~/
ln -sf "$dotfiles_dir/.tmux.conf" ~/
ln -sf "$dotfiles_dir/.gitconfig" ~/
ln -sf "$dotfiles_dir/.gitignore_global" ~/
ln -sf "$dotfiles_dir/.inputrc" ~/
ln -sf "$dotfiles_dir/.editrc" ~/

mkdir -p ~/.config/gtk-3.0
mkdir -p ~/.config/jesseduffield/lazygit
mkdir -p ~/Documents/tasks
ln -sf "$dotfiles_dir/gtk.css" ~/.config/gtk-3.0/
ln -sf "$dotfiles_dir/alacritty" ~/.config/
ln -sf "$dotfiles_dir/kitty" ~/.config/
ln -sf "$dotfiles_dir/ranger" ~/.config/
ln -sf "$dotfiles_dir/tealdeer" ~/.config/
ln -sf "$dotfiles_dir/lazygit/config.yml" ~/.config/jesseduffield/lazygit/
ln -sf "$dotfiles_dir/python_scripts/unzip_cn.py" ~/.local/bin/unzip_cn
ln -sf "$dotfiles_dir/taskwarrior/.taskrc" ~/
ln -sf "$dotfiles_dir/taskwarrior/.taskopenrc" ~/
ln -sf "$dotfiles_dir/taskwarrior/ayu.theme" ~/Documents/tasks/
ln -sfT "$dotfiles_dir/taskwarrior/vit" ~/.vit

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
    brew_pack[valgrind]=valgrind
    brew_pack[duf]=duf
    brew_pack[ncdu]=ncdu
    brew_pack[exa]=exa
    brew_pack[tldr]=tealdeer
    brew_pack[bat]=bat
    brew_pack[procs]=procs
    brew_pack[cpulimit]=cpulimit

    for exec_name in "${!brew_pack[@]}"; do
        if ! command -v $exec_name &> /dev/null; then
            brew install ${brew_pack[$exec_name]}
        fi
    done
elif [[ -x "$(command -v pacman)" ]]; then
    declare -A pacman_pack
    pacman_pack[lazygit]=lazygit
    pacman_pack[delta]=git-delta
    pacman_pack[clang-format]=clang
    pacman_pack[clangd]=clang
    pacman_pack[cppcheck]=cppcheck
    pacman_pack[shellcheck]=shellcheck
    pacman_pack[rg]=ripgrep
    pacman_pack[fd]=fd
    pacman_pack[xdotool]=xdotool
    pacman_pack[gdb]=gdb
    pacman_pack[valgrind]=valgrind
    pacman_pack[duf]=duf
    pacman_pack[ncdu]=ncdu
    pacman_pack[exa]=exa
    pacman_pack[tldr]=tealdeer
    pacman_pack[bat]=bat
    pacman_pack[procs]=procs
    pacman_pack[cpulimit]=cpulimit

    for exec_name in "${!pacman_pack[@]}"; do
        if command -v $exec_name &> /dev/null; then
            unset pacman_pack[$exec_name]
        fi
    done
    if [[ ${#pacman_pack[@]} -ge 1 ]]; then
        sudo pacman -S ${pacman_pack[*]}
    fi
else
    echo "Please first install homebrew manually!"
fi
