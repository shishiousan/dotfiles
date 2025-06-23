#! /usr/bin/fish

functions fisher >/dev/null
if test $status -ne 0
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
end

set -l plugins (cat $fish/fish_plugins)

for plugin in $plugins
    fisher install $plugin
end
