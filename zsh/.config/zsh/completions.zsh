# Use vim to view man page
compdef vman="man"

# Use taskwarrior's completion for vit
if command -v task &> /dev/null; then
    compdef vit="task"
fi
compdef vinfo="info"
