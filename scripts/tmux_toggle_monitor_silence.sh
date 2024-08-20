#!/usr/bin/env bash

MONITOR_SILENCE=$(tmux show-option -Avw monitor-silence)

if [ "$MONITOR_SILENCE" == "0" ]; then
	${SILENCE_DURATION:=$(tmux show-option -Avw @silence-duration)}
	${SILENCE_DURATION:=5}
	tmux set-option monitor-silence $SILENCE_DURATION
else
	# preserve the silence duration so that it can be restored when toggling back
	tmux set-option -w @silence-duration "$MONITOR_SILENCE"
	tmux set-option -w monitor-silence 0
fi
