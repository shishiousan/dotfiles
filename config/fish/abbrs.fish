#
# alias and abbreviation 
#

## moving directory
abbr -a db "cd $DROPBOX"
abbr -a odv "cd $ONEDRIVE"
# abbr -a de "cd $HOME/Desktop/"
# now I am using puffer-fish instead of them 
# alias ..2="cd ../.."
# alias ..3="cd ../../.."

## list up and read 
if command -q eza
    abbr -a ls "eza --icons"
    alias ls "eza --icons"
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
abbr -a gist "git status"
abbr -a gipr "git pull --rebase"
abbr -a gia "git add"
abbr -a gic "git commit"
abbr -a gico "git checkout"
abbr -a gip "git push"
abbr -a gibd "git branch -D"
abbr -a gil "git log"
abbr -a gid "git diff"
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

# others 
abbr -a c clear
abbr -a j "julia --color=yes"
abbr -a python python3
# abbr -a sz "source $zrc"
# abbr -a sb "source $brc"
