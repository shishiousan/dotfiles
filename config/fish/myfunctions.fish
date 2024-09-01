#
# User defined function
#

# NOTE: to enable "cd -"
functions -c cd standard_cd

function cd
    standard_cd $argv; and ls
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

function mdu -d "my disk usage function"
    if count $argv >/dev/null
        du -hs $argv | sort -hr | column -t | rs -j (ls -l | wc -l) 2 | less
    else
        du -hs * | sort -hr | column -t | rs -j (ls -l | wc -l) 2 | less
    end
end

function psm -d "process sorted by memory usage"
    argparse q/quiet -- $argv
    echo "more detail you can check by ps aux"
    ps aux | awk '{sum += $4} {ssum += $6} END {print "Total memory usage ",sum,"%,",ssum/1024,"MB(RSS)"}'
    if not set -ql _flag_quiet
        ps aux -e --sort -%mem | awk '{s=$11; sub(/^\/.*\//, "", s); print $2,$3,$4,$6,s}' | column -t | less
    end
end

function psc -d "process sorted by cpu usage"
    argparse q/quiet -- $argv
    set npr (nproc --all)
    echo "more detail you can check by ps aux"
    ps aux | awk -v var=$npr '{sum += $3} END {print "Total cpu usage ",sum,"% out of 100% x",var}'
    if not set -ql _flag_quiet
        ps aux -e --sort -%cpu | awk '{s=$11; sub(/^\/.*\//, "", s); print $2,$3,$4,$6,s}' | column -t | less
    end
end

function pst -d "process sorted by time "
    argparse q/quiet -- $argv
    echo "more detail you can check by ps aux"
    if not set -ql _flag_quiet
        ps aux -e --sort -time | awk '{s=$11; sub(/^\/.*\//, "", s); print $2,$3,$4,$6,$10,s}' | column -t | less
    end
end

function nvim
    argparse n/node -- $argv
    if set -ql _flag_node
        if [ -f $fish/functions/nvm.fish ]
            nvm use v16
        end
    end
    command nvim $argv
end

function ya
    yazi $argv
end

function v
    nvim $argv
end

function vvim
    nvim $nvim
end

function nv
    neovide --frame none $argv
end

function nvvim
    neovide --frame none $nvim
end

# function rebuild_easifem -d "Rebuild entire easifem liblaries"
#     set currentPath ( pwd )
#     argparse d/debug -- $argv
#     if set -ql _flag_debug
#         echo "debug mode is selected "
#         set script install.py
#     else
#         echo "release mode is selected "
#         set script release_install.py
#     end
#
#     set mylists base classes materials kernels elasticity acoustic
#     set mypaths $base $classes $elasticity $acoustic
#
#     if count $argv >/dev/null
#         easifem clean $mylists $argv
#     else
#         easifem clean $mylists
#     end
#
#     for ipath in $mypaths
#         cd $ipath
#         python3 $script
#     end
#     cd $currentPath
# end

# resolving opengl related issue 
function scilab
    set --export MESA_GL_VERSION_OVERRIDE 3.0
    command scilab $argv
end

function wofi
    command wofi --style $HOME/.config/wofi_theme/src/mocha/style.css $argv
end

function paraview
    argparse d/dark -- $argv
    if set -ql _flag_default
        command paraview --style=Fusion --stylesheet=$HOME/.config/ParaView/style.qss $argv
    else
        command paraview --style=Fusion $argv
    end
end

function mayavi
    set -l XDG_BACKEND x11
    command mayavi2
end

function fish_greeting -d "What's up fish!"
    if test "$GREETYOU" = 1
        echo "I'm ugly fish hahah..., hru?"
        fish_logo
    else
        # neofetch
        fastfetch
        set GREETYOU 1
    end
end

# activate vim mode without erasing any default key bindings 
function my_vi_mode
    for mode in default insert visual
        fish_default_key_bindings -M $mode
    end

    fish_vi_key_bindings --no-erase

    bind -M insert -m default jk cancel repaint-mode

    # Due to the cursor_default, it is redundant 
    # set fish_cursor_visual block
end

# reload fish config
function reload
    exec fish
    set -l config (status -f)
    echo "reloading: $config"
end

# ssh connection reactivate 
function ssh_reactivate
    eval (ssh-agent -c)
    set -Ux SSH_AGENT_PID $SSH_AGENT_PID
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    eval (ssh-add $HOME/.ssh/id_git_rsa)
end

## reference https://github.com/fish-shell/fish-shell/issues/296
function uniqVar --description 'Remove duplicates from environment variable'

    if test (count $argv) = 1
        set -l newvar
        set -l count 0
        for v in $$argv
            if contains -- $v $newvar
                set count (math $count+1)
            else
                set newvar $newvar $v
            end
        end
        set $argv $newvar
        test $count -gt 0
        and echo Removed $count duplicates from $argv
    else
        for a in $argv
            uniqVar $a
        end
    end
end

function echo_figs
    echo *.pdf
end
