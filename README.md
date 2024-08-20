# Tmux toggle monitoring

A set of tmux key bindings that make it easy to toggle monitor-* options for the current
window.

### Goals

- Provide easy to remember key bindings for toggling individual monitor-* options for the
  current window.

### Non-Goals

- Maximum Configurability.  The `@silence-duration` is configurable, but the key bindings are
  hard-coded.  While it might be nice to make these configurable, it is nearly as easy,
  and more flexible, to create your own key bindings using this plugin as an example.

### Configuration options

- `@silence-duration` - the number of seconds to use when monitor-silence is enabled. The
  default is 5 seconds.

### Key bindings

- `prefix + C-t + a` - toggle monitor-activity
- `prefix + C-t + b` - toggle monitor-bell
- `prefix + C-t + s` - toggle monitor-silence (between off and N seconds)
- `prefix + C-t + t` - toggle both monitor-activity and monitor-silence (to switch back and forth between the two)

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

```tmux
set -g @plugin 'pahindman/tmux-toggle-monitoring'
```

Hit `prefix + I` to fetch the plugin and source it. That's it!

### Manual Installation

Clone the repo:

    $ git clone https://github.com/pahindman/tmux-toggle-monitoring ~/clone/path

Add this line to the bottom of `.tmux.conf`:

```tmux
run-shell ~/clone/path/sensible.tmux
```

Reload TMUX environment with `$ tmux source-file ~/.tmux.conf`, and that's it.

### License

[MIT](LICENSE.md)
