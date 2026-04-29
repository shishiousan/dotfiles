#!/usr/bin/env bash

set -eu

main() {
  # nightfly colorscheme
  thm_bg="#011627"
  thm_fg="#bdc1c6"
  thm_cyan="#7fdbca"
  thm_black="#1d3b53"
  thm_gray="#7c8f8f"
  thm_magenta="#c792ea"
  thm_pink="#ae81ff"
  thm_red="#ff5874"
  thm_green="#a1cd5e"
  thm_yellow="#ecc48d"
  thm_blue="#82aaff"
  thm_orange="#e3d18a"
  thm_black4="#9ca1aa"

  separator="#[fg=${thm_gray},bg=default,none]▕#[default]"

  tmux set -g message-command-style "align=right,fg=${thm_blue}"
  tmux set -g message-style "align=right,fg=${thm_blue},align=centre"
  tmux set -g pane-active-border-style "fg=${thm_black4}"
  tmux set -g pane-border-style "fg=${thm_black}"

  # status bar
  # ================================================
  tmux set -g status "on"
  tmux set -g status-position "top"
  tmux set -g status-justify "left"
  tmux set -g status-style "none"

  # left panel
  tmux set -g status-left-length 100
  tmux set -g status-left-style "none,fg=${thm_black4},align=left"

  show_git_repo_and_branch="cd #{pane_current_path} && git rev-parse --is-inside-work-tree >/dev/null 2>&1 && echo \"  \$(git info slug -s) ${separator}   \$(git info branch --max-len 24 --short) ${separator}\""
  #
  tmux set -g status-left "#{?client_prefix, #[fg=${thm_red}]🐧 󰻀, #[fg=${thm_black4}]🐧 󰻀} #S ${separator} #(${show_git_repo_and_branch})"

  # right panel
  tmux set -g status-right-style "none, fg=${thm_black4}"
  tmux set -g status-right " %Y/%m/%d %a  #[fg=${thm_black4}]%I:%M%p"

  # window
  # ================================================
  tmux setw -g window-status-current-style "bold,fg=${thm_fg}"
  tmux setw -g window-status-activity-style "none,fg=${thm_black4}"
  tmux setw -g window-status-style "none,fg=${thm_black4}"
  tmux setw -g window-status-current-format "  #I #W ${separator}"
  tmux setw -g window-status-format "  #I #W ${separator}"
  tmux setw -g window-status-separator ""
}

main
