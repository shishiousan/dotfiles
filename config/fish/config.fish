if not status --is-interactive
    exit
end

# Load EASIFEM variable shell script
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

# Aliases
if [ -f $HOME/.config/fish/alias.fish ]
    source $HOME/.config/fish/alias.fish
end

# reload fish config
function reload
    exec fish
    set -l config (status -f)
    echo "reloading: $config"
end

# User paths
set -e fish_user_paths
set -U fish_user_paths $HOME/.bin $HOME/.local/bin $HOME/Applications $fish_user_paths

# Starship prompt
#if command -sq starship
#    starship init fish | source
#end

# sets tools
#set -x TERM alacritty
# Sets the terminal type for proper colors
set TERM xterm-256color

# Suppresses fish's intro message
set fish_greeting
function fish_greeting -d "What's up fish!"
    echo "I'm ugly fish hahah..., hru?"
    fish_logo
end

# Prevent directories names from being shortened
set -g theme_nerd_fonts yes

if status --is-login
    set -gx PATH $PATH ~/.bin
end

if status --is-login
    set -gx PATH $PATH ~/.local/bin
end

function ex --description "Extract bundled & compressed files"
    if test -f "$argv[1]"
        switch $argv[1]
            case '*.tar.bz2'
                tar xjf $argv[1]
            case '*.tar.gz'
                tar xzf $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.rar'
                unrar $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.tar'
                tar xf $argv[1]
            case '*.tbz2'
                tar xjf $argv[1]
            case '*.tgz'
                tar xzf $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.Z'
                uncompress $argv[1]
            case '*.7z'
                7z $argv[1]
            case '*.deb'
                ar $argv[1]
            case '*.tar.xz'
                tar xf $argv[1]
            case '*.tar.zst'
                tar xf $argv[1]
            case '*'
                echo "'$argv[1]' cannot be extracted via ex"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end

function less
    command less -R $argv
end

# NOTE: to enable "cd -"
functions -c cd standard_cd

function cd
    standard_cd $argv; and ls
end

# if status is-interactive  
#     # Commands to run in interactive sessions can go here
# end

# NOTE: In addition to following extra paths 
# one symlink to libgmsh.so.x.xx.x should be made 
# in $HOME/.easifem/install/easifem/extpkgs/lib 
set -gx GMSH_LIB $HOME/.local/lib/
set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH $HOME/.local/lib

# set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu
# set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH /usr/lib/python3.10/config-3.10-x86_64-linux-gnu


# oh-my-posh init fish | source
# oh-my-posh init fish --config $HOME/.config/omp/themes/catppuccin.omp.json | source
oh-my-posh init fish --config $HOME/.config/omp/themes/velvet.omp.json | source

if test -e $HOME/.nix-profile/etc/profile.d/nix.fish
    . $HOME/.nix-profile/etc/profile.d/nix.fish
end

# activate vim mode without erasing any default key bindings 
function my_vi_mode
    for mode in default insert visual
        fish_default_key_bindings -M $mode
    end

    fish_vi_key_bindings --no-erase

    bind -M insert -m default jj cancel repaint-mode

    # Due to the cursor_default, it is redundant 
    # set fish_cursor_visual block
end

set fish_cursor_default block
set fish_cursor_insert line blink
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
# Set the external cursor to a line. The external cursor appears when a command is started.
set fish_cursor_external line blink
set fish_vi_force_cursor 0

my_vi_mode
fish_vi_cursor
