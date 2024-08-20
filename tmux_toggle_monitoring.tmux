#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmux bind-key -r -T toggle-monitoring a set-option monitor-activity
tmux bind-key -r -T toggle-monitoring b set-option monitor-bell
tmux bind-key -r -T toggle-monitoring s run-shell "$CURRENT_DIR/scripts/tmux_toggle_monitor_silence.sh"
tmux bind-key    -T toggle-monitoring t run-shell "$CURRENT_DIR/scripts/tmux_toggle_monitor_silence.sh ; tmux set-option monitor-activity"
tmux bind-key C-m switch-client -T toggle-monitoring
