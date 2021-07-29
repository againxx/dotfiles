#!/bin/bash

# -e: exit immediately if a pipeline/a list/a compound command, exits with a non-zero status
# -u: fail on error and undefined variables
set -u

# fail on a single failed command in a pipeline
set -o pipefail

package_names=()
build_type=debug
all_packages=0
while [[ $# -ge 1 ]]; do
    case "$1" in
        --debug )
            build_type=debug;;
        --release )
            build_type=release;;
        --all )
            all_packages=1;;
        --none )
            all_packages=-1;;
        [!-][!-]* )
            package_names+=("$1");;
        * )
            echo "Invalid arguments! $1";;
    esac
    shift
done

catkin_ws_dir=$(catkin locate 2> /dev/null)
if [[ -z "$catkin_ws_dir" ]]; then
    current_path=$(pwd)
    while [[ $current_path != "/" ]]; do
        if [[  $current_path =~ .*ws$ && -d "$current_path/src" ]]; then
            catkin_ws_dir=$current_path
            break
        fi
        current_path=$(dirname "$current_path")
    done
fi

if [[ -z "$catkin_ws_dir" ]]; then
    echo "catkin worksapce not found!" >&2
    exit 1
fi

cd "$catkin_ws_dir" || {
    echo "Cannot change to workspace directory!" >&2
    exit 1
}

if [[ ! -d ".catkin_tools" ]]; then
    catkin init
    catkin config --profile $build_type --cmake-args -DCMAKE_BUILD_TYPE=${build_type^} -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_CXX_COMPILER_LAUNCHER=ccache
    catkin profile set $build_type
else
    mapfile -t available_build_type < <(catkin profile list --unformatted)
    if [[ "${available_build_type[*]}" != *"$build_type"* ]]; then
        catkin config --profile $build_type --cmake-args -DCMAKE_BUILD_TYPE=${build_type^} -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_CXX_COMPILER_LAUNCHER=ccache
        catkin clean
    else
        if (( ${#package_names[@]} != 0 || all_packages == 1 )); then
            catkin clean
        fi
    fi
    catkin profile set $build_type
fi

if (( all_packages == 1 )); then
    catkin build
elif (( all_packages != -1 && ${#package_names[@]} > 0 )); then
    catkin build "${package_names[@]}"
fi

if (( ${#package_names[@]} == 0 || all_packages == 1 )); then
    mapfile -t package_names < <(catkin list --unformatted)
fi

for package_name in "${package_names[@]}"; do
    if [[ -f "$catkin_ws_dir/build/$package_name/compile_commands.json" ]]; then
        ln -sf "$catkin_ws_dir/build/$package_name/compile_commands.json" "$(catkin locate "$package_name")/"
    fi
done

mkdir -p src/.vim
cp ~/dotfiles/vim/asynctasks/catkin_tasks.ini src/.tasks
cp ~/dotfiles/clang_formats/ros-clang-format src/.clang-format
cp ~/dotfiles/vim/vimrc/catkin-coc-settings.json src/.vim/coc-settings.json

echo -e "\n"
echo "======================================"
echo "catkin workspace has been initialized!"
echo "======================================"
exit 0
