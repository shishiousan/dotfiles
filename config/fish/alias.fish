if status is-interactive
    # Commands to run in interactive sessions can go here
end
#
# variable
#
set --export DROPBOX "$HOME/Dropbox"
set --export ONEDRIVE "$HOME/OneDrive"
set --export brc "$HOME/.bashrc"
set --export zrc "$HOME/.zshrc"
set --export crcb "$HOME/.customrc_bash"
set --export crcf "$HOME/.customrc_fish"
set --export nvim "$DROPBOX/dotfiles/config/nvim"
set --export lazy "$HOME/.local/share/nvim/lazy"
# set --export fish "$DROPBOX/dotfiles/config/fish"
set --export fish "$HOME/.config/fish"
set --export EDITOR nvim
set --export VIMTEX_OUTPUT_DIRECTORY build
set --export BROWSER brave
set --export JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64/
set --export docs "/home/shion/easifem-fortran.github.io/docs/docs-api"
set --export DENO_INSTALL "/home/shion/.deno"
#easifem-dev related 
set --export easifem "$DROPBOX/easifem"
set --export base "$easifem/base"
set --export classes "$easifem/classes"
set --export elasticity "$easifem/elasticity"
set --export acoustic $easifem/acoustic
set --export OMP_NUM_THREADS 1
set --export OPENBLAS_NUM_THREADS 1

# sci lab 
set --export SCI /usr/share/scilab/

# set --export pyflags -L/usr/lib/python3.10/config-3.10-x86_64-linux-gnu -L/usr/lib/x86_64-linux-gnu -lpython3.10 -lcrypt -ldl -lm -lm

set -gx PATH $PATH $DENO_INSTALL/bin
set -gx PATH $PATH /opt/ParaView/bin/
set -gx PATH $PATH /opt/smartgit/bin/
set -gx PATH $PATH $HOME/.cargo/bin/
set -gx PATH $PATH $HOME/.npm-global/bin/
set -gx PATH $PATH $HOME/go/bin/
set -gx PATH $PATH $HOME/anaconda3/bin
set -gx PATH $PATH /usr/local/win/bin

# alias
#moving 
alias db="cd $DROPBOX"
alias odv="cd $ONEDRIVE"
alias de="cd $HOME/Desktop/"
alias ..2="cd ../.."
alias ..3="cd ../../.."

#ls command 
# WARN: these commands needs a lsd 
# please intall through cargo
if [ -f $HOME/.cargo/bin/lsd ]
    alias ls="lsd"
end

alias l="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias lt="ls --tree"

#safe action
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

#others 
alias c="clear"
alias j="julia --color=yes"
alias sz="source $zrc"
alias sb="source $brc"
alias gist="git status"
alias python="python3"

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

function rebuild_easifem -d "Rebuild entire easifem liblaries"
    set currentPath $pwd
    argparse d/debug -- $argv
    if set -ql _flag_debug
        echo "debug mode is selected "
        set script install.py
    else
        echo "release mode is selected "
        set script release_install.py
    end

    set mylists base classes materials kernels elasticity acoustic
    set mypaths $base $classes $elasticity $acoustic

    if count $argv >/dev/null
        easifem clean $mylists $argv
    else
        easifem clean $mylists
    end

    for ipath in $mypaths
        cd $ipath
        python3 $script
    end
    cd $currentPath
end

# resolving opengl related issue 
function scilab
    set --export MESA_GL_VERSION_OVERRIDE 3.0
    command scilab $argv
end
