if status is-interactive
    # Commands to run in interactive sessions can go here
end
#
# variable
#
set --export DROPBOX "$HOME/Dropbox"
set --export brc "$HOME/.bashrc"
set --export zrc "$HOME/.zshrc"
set --export crcb "$HOME/.customrc_bash"
set --export crcf "$HOME/.customrc_fish"
set --export nvim "$DROPBOX/dotfiles/config/nvim"
set --export lazy "$HOME/.local/share/nvim/lazy"
# set --export fish "$DROPBOX/dotfiles/config/fish"
set --export fish "$HOME/.config/fish"
set --export VIMTEX_OUTPUT_DIRECTORY build
set --export JULIA_NUM_THREADS 4
set --export BROWSER brave
set --export JAVA_HOME /usr/lib/jvm/java-20-openjdk/
# set --export JAVA_OPTS -Xmx1024m

set -x PATH /home/shion/perl5/bin $PATH 2>/dev/null
set -q PERL5LIB; and set -x PERL5LIB /home/shion/perl5/lib/perl5:$PERL5LIB
set -q PERL5LIB; or set -x PERL5LIB /home/shion/perl5/lib/perl5
set -q PERL_LOCAL_LIB_ROOT; and set -x PERL_LOCAL_LIB_ROOT /home/shion/perl5:$PERL_LOCAL_LIB_ROOT
set -q PERL_LOCAL_LIB_ROOT; or set -x PERL_LOCAL_LIB_ROOT /home/shion/perl5
set -x PERL_MB_OPT --install_base\ \"/home/shion/perl5\"
set -x PERL_MM_OPT INSTALL_BASE=/home/shion/perl5

# alias
#moving 
alias db="cd $DROPBOX"
alias ..2="cd ../.."
alias ..3="cd ../../.."

#ls command 
alias ls="lsd"
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
alias sd="sudo shutdown now"
alias sz="source $zrc"
alias sb="source $brc"
alias gist="git status"

# path
fish_add_path /opt/Paraview/bin/
fish_add_path $HOME/.cargo/bin
fish_add_path $PATH:/opt/smartgit/bin
fish_add_path $PATH:~/.npm-global/bin
fish_add_path $PATH:$HOME/go/bin

function v
    nvim $argv
end

function vvim
    nvim "$nvim"
end
