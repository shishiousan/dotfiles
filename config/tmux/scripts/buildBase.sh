#! /bin/bash

session="buildBase"
# cmd="easifem install base --no-download"
cmd="easifem dev base"
window=${session}:0
pane=${window}.4

if [ "$(tmux display-message -p -F "#{session_name}")" = "${session}" ]; then
  tmux detach-client
else
  # Create new session with the session name
  tmux new-session -d -s "$session"

  # Send the command to the session
  tmux send-keys -t "$session" "$cmd" Enter

  # Create a popup window that runs the command directly (fish-compatible)
  tmux display-popup -d '#{pane_current_path}' -xR -yC -w30% -h100% -E "fish -c '$cmd; echo \"Press Enter to close...\"; read'"
fi
