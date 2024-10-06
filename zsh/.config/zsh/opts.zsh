# ROS working space related
if [ -d /opt/ros ]; then
    source /opt/ros/*/setup.zsh
fi

if command -v brew &> /dev/null; then
    # Use Tsinghua homebrew bottle source
    export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
    export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
    export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
    export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
fi

if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
    . "$HOME/anaconda3/etc/profile.d/conda.sh"
fi

if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
    . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
fi

# If we have ROS then do not source anaconda automatically
# if [ -z "$ROS_ROOT" ] && command -v conda &> /dev/null; then
#     conda activate base
# fi

if command -v kitty &> /dev/null; then
    kitty + complete setup zsh | source /dev/stdin
fi

if [ -f "$HOME/.config/broot/launcher/bash/br" ]; then
    source "$HOME/.config/broot/launcher/bash/br"
fi
