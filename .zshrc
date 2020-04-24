# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Tmux
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOSTART_ONCE=true
ZSH_TMUX_AUTOCONNECT=true
ZSH_TMUX_FIXTERM_WITH_256COLOR=tmux-256color

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/ustc-1314/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

source ~/vim_zsh_tmux/powlevel9k_conf.zsh

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"  # zsh will repeat the command in output in neovim terminal with this line commented

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# This configuration is overrided by fzf
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    python
    pip
    vi-mode
    tmux
    zsh-syntax-highlighting
    extract
    zsh-autosuggestions
    zsh-completions
    autojump
    colored-man-pages
    conda-zsh-completion
)

source $ZSH/oh-my-zsh.sh

# This autoload should put below the line "source $ZSH/oh-my-zsh.sh"
# Reference: https://github.com/esc/conda-zsh-completion/issues/26
autoload -U compinit && compinit

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
# export LANG=zh_CN.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

# Use vim to view man page
export PATH="$PATH:$HOME/.vim/plugged/vim-superman/bin"
compdef vman="man"

bindkey -v
KEYTIMEOUT=1
### bindkey ctrl+j for partial accept zsh-autosuggestions
### bindkey ctrl+l for complete accept zsh-autosuggestions
### bindkey alt+l for clear screen
bindkey "^J" forward-word
bindkey "^L" forward-char
bindkey "^[l" clear-screen

bindkey -M vicmd "_" vi-first-non-blank

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# alias ra="ranger" # use ra() function instead
alias pch="proxychains"
alias zshconf="nvim ~/.zshrc"
alias tmuxconf="nvim ~/.tmux.conf"
alias kittyconf="nvim ~/.config/kitty/kitty.conf"
alias alaconf="nvim ~/.config/alacritty/alacritty.yml"

alias -s cpp=nvim
alias -s h=nvim
alias -s md=nvim
alias -s txt=nvim

mkcd() {
    mkdir -p $1; cd $1
}

ra() {
    if [ -z "$RANGER_LEVEL" ]; then
        if [ "$1" != "" ]; then
            if [ -d "$1" ]; then
                ranger "$1"
            else
                ranger "$(autojump $1)"
            fi
        else
            ranger
        fi
        return $?
    else
        exit
    fi
}

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# ROS working space related
# source /opt/ros/indigo/setup.zsh
# source /home/ustc-1314/catkin_ws/devel/setup.zsh
# source /home/ustc-1314/iroboscan/CatkinWorkSpace/devel/setup.zsh
# source /home/ustc-1314/rl_scanning/EnvironmentWorkSpace/devel/setup.zsh

# ROS related
# export TURTLEBOT_3D_SENSOR=kinect
# export TURTLEBOT_BATTERY=/sys/class/power_supply/BAT1
# export ROS_MASTER_URI=http://192.168.0.100:11311
# export ROS_IP=192.168.0.100
# export ROS_MASTER_URI=http://localhost:11311

# For colourize ls dir
# eval `dircolors /home/ustc-1314/.dir_colors/dircolors`

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ustc-1314/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ustc-1314/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ustc-1314/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ustc-1314/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
kitty + complete setup zsh | source /dev/stdin

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
