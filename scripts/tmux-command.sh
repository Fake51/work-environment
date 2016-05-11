#!/bin/bash
/usr/bin/tmux list-sessions -F '#{session_name}' | /usr/bin/xargs -I SESS /usr/bin/tmux list-windows -t SESS -F 'SESS:#{window_index}' | /usr/bin/xargs -I SESS_WIN /usr/bin/tmux list-panes -t SESS_WIN -F 'SESS_WIN.#{pane_index}' | /usr/bin/xargs -I SESS_WIN_PANE /usr/bin/tmux send-keys -t SESS_WIN_PANE "$1" Enter
