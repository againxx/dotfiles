#!/bin/bash

declare -a package_names
build_type=debug
while [ -n "$1" ]; do
    case "$1" in
        --debug )
            build_type=debug;;
        --release )
            build_type=release;;
        [!-][!-]* )
            package_names+=("$1");;
            * )
            echo "Invalid arguments! $1";;
    esac
    shift
done

current_path=$(pwd)
while [[ $current_path != "/" ]]; do
    if [[  $current_path =~ .*ws$ && -d "$current_path/src" ]]; then
        catkin_ws_dir=$current_path
        break
    fi
    current_path=$(dirname "$current_path")
done

if [ -z "$catkin_ws_dir" ]; then
    echo "catkin worksapce not found!" >&2
    exit 1
fi

cd "$catkin_ws_dir" || {
    echo "Cannot change to workspace directory!" >&2
    exit 1
}

if [[ ! -d ".catkin_tools" ]]; then
    catkin init
    catkin config --profile $build_type --cmake-args -DCMAKE_BUILD_TYPE=${build_type^} -DCMAKE_EXPORT_COMPILE_COMMANDS=1
    catkin profile set $build_type
fi

catkin build "${package_names[@]}"

if (( ${#package_names[@]} == 0 )); then
    mapfile -t package_names < <(catkin list --unformatted)
fi

for package_name in "${package_names[@]}"; do
    if [[ -f "$catkin_ws_dir/build/$package_name/compile_commands.json" ]]; then
        ln -sf "$catkin_ws_dir/build/$package_name/compile_commands.json" "src/$package_name/"
    fi
done

cp ~/dotfiles/asynctasks/catkin_tasks.ini src/.tasks
cp ~/dotfiles/clang_formats/ros-clang-format src/.clang-format

echo "catkin workspace has been initialized"
exit 0
