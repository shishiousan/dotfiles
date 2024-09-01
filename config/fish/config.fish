if not status --is-interactive
    exit
end

if [ -f $HOME/.config/easifem/easifemvar.fish ]
    source $HOME/.config/easifem/easifemvar.fish
end
# Load private config
if [ -f $HOME/.config/fish/private.fish ]
    source $HOME/.config/fish/private.fish
end

# Git
if [ -f $HOME/.config/fish/git.fish ]
    source $HOME/.config/fish/git.fish
end

if [ -f $HOME/.config/fish/variables.fish ]
    source $HOME/.config/fish/variables.fish
end

# abbreviations
if [ -f $HOME/.config/fish/abbrs.fish ]
    source $HOME/.config/fish/abbrs.fish
end

# myfunctions
if [ -f $HOME/.config/fish/myfunctions.fish ]
    source $HOME/.config/fish/myfunctions.fish
end

# User paths
set -e fish_user_paths
set -U fish_user_paths $HOME/.bin $HOME/.local/bin $HOME/Applications $fish_user_paths

# sets tools
#set -x TERM alacritty
# Sets the terminal type for proper colors
set TERM xterm-256color

# Suppresses fish's intro message
set fish_greeting

# Prevent directories names from being shortened
set -g theme_nerd_fonts yes

if status --is-login
    set -gx PATH $PATH ~/.bin
end

if status --is-login
    set -gx PATH $PATH ~/.local/bin
end

if command -q oh-my-posh
    #oh-my-posh init fish | source
    #oh-my-posh init fish --config $HOME/.config/omp/themes/catppuccin.omp.json | source
    oh-my-posh init fish --config $HOME/.config/omp/themes/velvet.omp.json | source
end

# if not pgrep --full ssh-agent | string collect >/dev/null
#     eval (ssh-agent -c)
#     set -Ux SSH_AGENT_PID $SSH_AGENT_PID
#     set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
#     eval (ssh-add $HOME/.ssh/id_git_rsa)
# end

set fish_cursor_default block
set fish_cursor_insert line blink
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
# Set the external cursor to a line. The external cursor appears when a command is started.
set fish_cursor_external line blink
set fish_vi_force_cursor 0
# init vi mode 
my_vi_mode
fish_vi_cursor --force

# installing npm packages locally
set NPM_PACKAGES "$HOME/.npm-packages"
set NODE_PATH "$NPM_PACKAGES/lib/node_modules" $NODE_PATH
set PATH $PATH $NPM_PACKAGES/bin
set MANPATH $NPM_PACKAGES/share/man $MANPATH

# pnpm
set -gx PNPM_HOME "/home/shion/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/shion/miniconda3/bin/conda
    # eval /home/easifem/miniconda3/bin/conda "shell.fish" hook $argv | source
end

if test -f /home/shion/miniconda3/etc/fish/conf.d/conda.fish
    source /home/shion/miniconda3/etc/fish/conf.d/conda.fish
end
# <<< conda initialize <<<
