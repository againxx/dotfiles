DOTFILES_DIR=$(dirname $(realpath $0))

ln -sf $DOTFILES_DIR/vimrc/.vimrc ~/
ln -sf $DOTFILES_DIR/.zshrc ~/
ln -sf $DOTFILES_DIR/.bashrc ~/
ln -sf $DOTFILES_DIR/.tmux.conf ~/
ln -sf $DOTFILES_DIR/.gitconfig ~/
ln -sf $DOTFILES_DIR/.gitignore_global ~/

mkdir -p ~/.config/gtk-3.0
mkdir -p ~/.config/jesseduffield/lazygit
ln -sf $DOTFILES_DIR/gtk.css ~/.config/gtk-3.0/
ln -sf $DOTFILES_DIR/alacritty ~/.config/
ln -sf $DOTFILES_DIR/kitty ~/.config/
ln -sf $DOTFILES_DIR/ranger ~/.config/
ln -sf $DOTFILES_DIR/lazygit/config.yml ~/.config/jesseduffield/lazygit/

if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if command -v brew &> /dev/null; then
    # Use USTC homebrew source
    cd "$(brew --repo)"
    if [ $(git remote get-url origin) != "https://mirrors.ustc.edu.cn/brew.git" ]; then
        git remote set-url origin https://mirrors.ustc.edu.cn/brew.git
    fi
    cd "$(brew --repo homebrew/core)"
    if [ $(git remote get-url origin) != "https://mirrors.ustc.edu.cn/linuxbrew-core.git" ]; then
        git remote set-url origin https://mirrors.ustc.edu.cn/linuxbrew-core.git
    fi
    cd $DOTFILES_DIR

    if ! command -v lazygit &> /dev/null; then
        brew install jesseduffield/lazygit/lazygit
    fi

    if ! command -v delta &> /dev/null; then
        brew install git-delta
    fi
else
    echo "Please first install homebrew manually!"
fi
