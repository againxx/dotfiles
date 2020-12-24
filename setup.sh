DOTFILES_DIR=$(dirname $(realpath $0))

ln -sf $DOTFILES_DIR/vimrc/.vimrc ~/
ln -sf $DOTFILES_DIR/.zshrc ~/
ln -sf $DOTFILES_DIR/.bashrc ~/
ln -sf $DOTFILES_DIR/.tmux.conf ~/
ln -sf $DOTFILES_DIR/.gitconfig ~/
ln -sf $DOTFILES_DIR/.gitignore_global ~/

mkdir -p ~/.config/gtk-3.0
ln -sf $DOTFILES_DIR/gtk.css ~/.config/gtk-3.0/
ln -sf $DOTFILES_DIR/alacritty ~/.config/
ln -sf $DOTFILES_DIR/kitty ~/.config/
ln -sf $DOTFILES_DIR/ranger ~/.config/

if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
