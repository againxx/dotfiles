# ROS working space related
if noglob [ -f /opt/ros/*/setup.zsh ]; then
    source /opt/ros/*/setup.zsh
fi

if command -v brew &> /dev/null; then
    # Use USTC homebrew bottle source
    export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/linuxbrew-bottles
fi

if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
    . "$HOME/anaconda3/etc/profile.d/conda.sh"
fi

if [ -z "$ROS_ROOT" ] && command -v conda &> /dev/null; then
    conda activate base
fi

if command -v kitty &> /dev/null; then
    kitty + complete setup zsh | source /dev/stdin
fi

if [ -f "$HOME/.config/broot/launcher/bash/br" ]; then
    source "$HOME/.config/broot/launcher/bash/br"
fi
