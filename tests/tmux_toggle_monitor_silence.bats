#!/usr/bin/env bats

setup() {
	export TMUX_TMPDIR
	TMUX_TMPDIR="$(mktemp -d)"
	unset TMUX

	export SILENCE_DEFAULT
	SILENCE_DEFAULT=5

	tmux -f /dev/null new-session -d -s bats-test
	tmux set-option -w -t bats-test:0 monitor-silence 0
	tmux set-option -u -w -t bats-test:0 @silence-duration
}

teardown() {
	tmux kill-server >/dev/null 2>&1 || true
	rm -rf "$TMUX_TMPDIR"
}

@test "when @silence-duration is not set, toggling on sets monitor-silence to the default" {
	script="$BATS_TEST_DIRNAME/../scripts/tmux_toggle_monitor_silence.sh"

	run tmux run-shell -t bats-test:0 "sh '$script'"
	[ "$status" -eq 0 ]

	run tmux show-option -v -w -t bats-test:0 monitor-silence
	[ "$status" -eq 0 ]
	[ "$output" = "$SILENCE_DEFAULT" ]
}

@test "when @silence-duration is set, toggling on sets monitor-silence to the @silence-duration" {
	script="$BATS_TEST_DIRNAME/../scripts/tmux_toggle_monitor_silence.sh"

	local random_value=$RANDOM
	run tmux set-option -w -t bats-test:0 @silence-duration $random_value
	[ "$status" -eq 0 ]

	run tmux run-shell -t bats-test:0 "sh '$script'"
	[ "$status" -eq 0 ]

	run tmux show-option -v -w -t bats-test:0 monitor-silence
	[ "$status" -eq 0 ]
	[ "$output" = "$random_value" ]
}

@test "toggling off sets monitor-silence to zero and @silence-duration to the previous monitor-silence" {
	script="$BATS_TEST_DIRNAME/../scripts/tmux_toggle_monitor_silence.sh"

	local random_value=$RANDOM
	run tmux set-option -w -t bats-test:0 monitor-silence $random_value
	[ "$status" -eq 0 ]

	run tmux run-shell -t bats-test:0 "sh '$script'"
	[ "$status" -eq 0 ]

	run tmux show-option -v -w -t bats-test:0 monitor-silence
	[ "$status" -eq 0 ]
	[ "$output" = "0" ]

	run tmux show-option -v -w -t bats-test:0 @silence-duration
	[ "$status" -eq 0 ]
	[ "$output" = "$random_value" ]
}

@test "repeated toggling preserves the @silence-duration" {
	script="$BATS_TEST_DIRNAME/../scripts/tmux_toggle_monitor_silence.sh"

	local random_value=$RANDOM
	run tmux set-option -w -t bats-test:0 @silence-duration $random_value
	[ "$status" -eq 0 ]

	run tmux run-shell -t bats-test:0 "sh '$script'"
	[ "$status" -eq 0 ]

	run tmux run-shell -t bats-test:0 "sh '$script'"
	[ "$status" -eq 0 ]

	run tmux run-shell -t bats-test:0 "sh '$script'"
	[ "$status" -eq 0 ]

	run tmux show-option -v -w -t bats-test:0 @silence-duration
	[ "$status" -eq 0 ]
	[ "$output" = "$random_value" ]
}
