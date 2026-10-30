#!/usr/bin/env bash
PIDFILE="/tmp/hyprland_macro_f18.pid"

# If an instance is already running, kill it and exit (Toggle OFF)
if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    kill "$(cat "$PIDFILE")"
    rm -f "$PIDFILE"
    exit 0
fi

# Otherwise, save current PID and start looping (Toggle ON)
echo $$ > "$PIDFILE"
trap 'rm -f "$PIDFILE"; exit' EXIT INT TERM

while true; do
    # Key '2' linux keycode is 3 (3:1 = down, 3:0 = up)
    ydotool key 3:1 3:0
    sleep 0.15
    
    # Key '3' linux keycode is 4 (4:1 = down, 4:0 = up)
    ydotool key 4:1 4:0
    sleep 0.15
done
