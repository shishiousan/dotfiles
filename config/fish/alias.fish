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
set --export JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64/


#easifem-dev related 
set --export easifem "$DROPBOX/easifem"
set --export base "$easifem/base"
set --export classes "$easifem/classes"

# set --export JAVA_OPTS -Xmx1024m

# alias
#moving 
alias db="cd $DROPBOX"
alias de="cd $HOME/Desktop/"
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
# fish_add_path /opt/Paraview/bin/
# fish_add_path ~/.cargo/bin
# fish_add_path /opt/smartgit/bin
# fish_add_path ~/.npm-global/bin
# fish_add_path ~/go/bin

function v
    nvim $argv
end

function vvim
    nvim "$nvim"
end
