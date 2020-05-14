DOTFILES_DIR=$(dirname $(realpath $0))

ln -sf $DOTFILES_DIR/vimrc/.vimrc ~/.vimrc
ln -sf $DOTFILES_DIR/.zshrc ~/.zshrc
ln -sf $DOTFILES_DIR/.tmux.conf ~/.tmux.conf
ln -sf $DOTFILES_DIR/.gitconfig ~/.gitconfig
ln -sf $DOTFILES_DIR/.gitignore_global ~/.gitignore_global

mkdir -p ~/.config/gtk-3.0
ln -sf $DOTFILES_DIR/gtk.css ~/.config/gtk-3.0/gtk.css
ln -sf $DOTFILES_DIR/alacritty ~/.config/alacritty
ln -sf $DOTFILES_DIR/kitty ~/.config/kitty
ln -sf $DOTFILES_DIR/ranger ~/.config/ranger
