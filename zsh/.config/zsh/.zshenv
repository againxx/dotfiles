# Define Zim location
: ${ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim}
skip_global_compinit=1
export RANGER_ZLUA="$ZIM_HOME/modules/z.lua/z.lua"
