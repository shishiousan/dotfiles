
function etest -d "efficient easifem test"
    set currentPath ( pwd )

    argparse \
        c/classes b/base \
        a/acoustic e/elasticity \
        'n/modname=' -- $argv
    or return 1

    set cands "easifemBase\neasifemClasses\neasifemAcoustic\neasifemElasticity"

    if set -ql _flag_acoustic
        set eflag easifemAcoustic
    else if set -ql _flag_elasticity
        set eflag easifemElasticity
    else if set -ql _flag_classes
        set eflag easifemClasses
    else if set -ql _flag_base
        set eflag easifemBase
    else if set -ql _flag_modname
        set eflag $_flag_modname
    else
        set eflag (echo -e $cands | fzf )
    end

    if count $argv >/dev/null
        easifem run -e $eflag -f $argv
    else
        builtin cd $docs
        set dirname (find . -type d | fzf )
        easifem run -e $eflag -f (find $dirname -name "*.[fF]*" -o -name "*.md" -type f | fzf )
    end

    builtin cd $currentPath
end
