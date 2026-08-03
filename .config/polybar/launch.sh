#!/usr/bin/env bash

# Terminate already running bar instances
polybar-msg cmd quit

# Wait until processes have shut down
while pgrep -x polybar >/dev/null; do sleep 0.2; done

# Launch bar(s)
polybar
