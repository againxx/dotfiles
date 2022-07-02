container() {
    pid=$$
    while true; do
        pid=$(ps -h -o ppid -p $pid 2>/dev/null)
        case $(ps -h -o comm -p $pid 2>/dev/null) in
        (gnome-terminal) echo "Running in gnome terminal";return;;
        (xterm) echo "Running in xterm";return;;
        (rxvt) echo "Running in rxvt";return;;
        (kitty) echo "Running in kitty";return;;
        (python) if [ ! -z "$(ps -h -o args -p $pid 2>/dev/null | grep guake)" ]; then echo "Running in Guake"; return; fi ;;
        esac
        [[ $(echo $pid) == 1 ]] && break
    done
}
container
