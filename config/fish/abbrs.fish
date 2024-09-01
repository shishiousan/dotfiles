#
# alias and abbreviation 
#

## moving directory
abbr -a db "cd $DROPBOX"
abbr -a odv "cd $ONEDRIVE"
abbr -a cdd "cd $HOME/Downloads"
abbr -a cdc "cd $HOME/.config"
# abbr -a de "cd $HOME/Desktop/"
# now I am using puffer-fish instead of them 
# alias ..2="cd ../.."
# alias ..3="cd ../../.."

## list up and read 
if command -q eza
    abbr -a ls "eza --icons always"
    alias ls "eza --icons always"
end
abbr -a l ls -l
abbr -a la ls -a
abbr -a lla ls -la
abbr -a lt ls --tree
# cat to bad iff exist 
if command -q bat
    # alias cat="bat"
    abbr -a less bat
    alias less bat
end

## safe action
abbr -a cp "cp -i"
abbr -a mv "mv -i"
abbr -a rm "rm -i"

## git action
abbr -a gi "git init"
abbr -a gist "git status"
abbr -a gipr "git pull --rebase"
abbr -a gia "git add"
abbr -a gic "git commit"
abbr -a gico "git checkout"
abbr -a gip "git push"
abbr -a gir "git restore"
abbr -a girb "git rebase"
abbr -a gibd "git branch -D"
abbr -a gil "git log"
abbr -a gis "git stash"
abbr -a gisp "git stash pop"
if command -q git-graph
    abbr -a gilg git-graph
else
    abbr -a gilg "git log -graph"
end

## tmux 
abbr -a tn "tmux new -s"
abbr -a ta "tmux attach -t"
abbr -a tl "tmux ls"
abbr -a tk "tmux kill-session -t"
abbr -a tka "tmux kill-session -a"
abbr -a tks "tmux kill-server "
abbr -a tds "tmux detach -s"
abbr -a td "tmux detach"
abbr -a tsk "tmux send-keys -t "

## docker 
abbr -a dbd "docker build . -t "
abbr -a dig "docker images "
abbr -a dil "docker image ls "
abbr -a dex "docker exec -it "
abbr -a drn "docker run -it -d --name shion_"
abbr -a dst "docker stop "
abbr -a drm "docker rm "
abbr -a dirm "docker image rm "
abbr -a dps "docker ps "
abbr -a dpa "docker ps -a "
abbr -a dpl "docker pull "

# deepl cli 
abbr -a etj --set-cursor=! 'deepl -i "!" -t ja'
abbr -a jte --set-cursor=! 'deepl -i "!" -t en'

# others 
abbr -a c clear
abbr -a j "julia --color=yes"
abbr -a python python3
abbr -a gpp "gnuplot --persist"
abbr -a gp gnuplot
abbr -a figs --position anywhere "*.pdf *.svg *.eps"
# abbr -a figs --position anywhere --function echo_figs
# abbr -a sz "source $zrc"
# abbr -a sb "source $brc"

abbr -a envls bat $econ/easifem.toml
