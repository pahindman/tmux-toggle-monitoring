#!/usr/bin/env bats

setup() {
  export TMUX_TMPDIR
  TMUX_TMPDIR="$(mktemp -d)"
  unset TMUX

  tmux -f /dev/null new-session -d -s bats-test
  tmux set-option -w -t bats-test:0 monitor-silence 0
  tmux set-option -u -w -t bats-test:0 @silence-duration
}

teardown() {
  tmux kill-server >/dev/null 2>&1 || true
  rm -rf "$TMUX_TMPDIR"
}

@test "toggle silence from off to default 5" {
  script="$BATS_TEST_DIRNAME/../scripts/tmux_toggle_monitor_silence.sh"

  tmux run-shell -t bats-test:0 "sh '$script'; tmux wait-for -S bats-toggle-done"
  tmux wait-for bats-toggle-done

  run tmux show-option -v -w -t bats-test:0 monitor-silence
  [ "$status" -eq 0 ]
  [ "$output" = "5" ]
}
