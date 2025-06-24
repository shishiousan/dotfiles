#
# variable
#

# fish 
# suppress reflow when the terminal is resized 
set -gx fish_handle_reflow 0

set --export DROPBOX "$HOME/Dropbox"
set --export ONEDRIVE "$HOME/OneDrive"
set --export brc "$HOME/.bashrc"
set --export zrc "$HOME/.zshrc"
# set --export nvim "$DROPBOX/dotfiles/config/nvim"
set --export nvim "$DROPBOX/src/PengVim"
set --export pengvim "$DROPBOX/src/PengVim"
set --export lazy "$HOME/.local/share/nvim/lazy"
# set --export fish "$DROPBOX/dotfiles/config/fish"
set --export fish "$HOME/.config/fish"
set --export config "$HOME/.config"
set --export writing "$DROPBOX/writing"
set --export news "$DROPBOX/dotfiles/newsboat"
set --export sharing "$DROPBOX/sharing"
set --export myrepo "$DROPBOX/src"
set --export CRYPTOGRAPHY_OPENSSL_NO_LEGACY 1
set --export EDITOR nvim
set --export VIMTEX_OUTPUT_DIRECTORY build
set --export BROWSER zen-browser
set --export JAVA_HOME /usr/lib/jvm/java-21-openjdk/
set --export DENO_INSTALL "/home/shion/.deno"

#easifem-dev related 
set --export easifem "$DROPBOX/easifem"
set --export base "$easifem/base"
set --export classes "$easifem/classes"
set --export elasticity "$easifem/elasticity"
set --export scalarwave $easifem/scalarWave
set --export ere $HOME/easifem-results
set --export easifemdocs $easifem/easifem.github.io
set --export docs $easifem/easifem.github.io/docs/docs-api
set --export lec $easifem/lectures/docs
set --export econ $easifem/config
set --export eplay $easifem/easifem_playground
set --export easigo $easifem/easifemGO
set --export easifish $easifem/easifem-fish-utility
set --export OMP_NUM_THREADS 1
set --export OPENBLAS_NUM_THREADS 1

# fzf 
set -gx TMUX_FZF_OPTIONS '-p 80%'
set -gx FZF_DEFAULT_OPTS --color=bg+:#2d3036,border:#ffffff,spinner:#ff5ef1,hl:#7b8496,fg:#ffffff,header:#7b8496,info:#5ef1ff,pointer:#ff5ef1,marker:#ffbd5e,fg+:#ffffff,prompt:#ff5ef1,hl+:#ff5ef1
set -U FZF_COMPLETE 0

# gtk dark 
# NOTE: following variables are written in /etc/environment
# set --export GTK_THEME Adwaita:dark
# set --export GTK2_RC_FILES /usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
# set --export QT_STYLE_OVERRIDE Adwaita-dark

# sci lab 
set --export SCI /usr/share/scilab/

# nnn 
set --export NNN_PLUG "p:preview-tui"

# deepl cli 
set --export DEEPL_AUTH_KEY (cat $fish/deepl_key.txt 2>/dev/null)

### 
# PATH 
###
set -gx PATH $PATH $DENO_INSTALL/bin
set -gx PATH $PATH /opt/ParaView/bin/
set -gx PATH $PATH /opt/zotero
set -gx PATH $PATH /opt/bucklespring/
set -gx PATH $PATH $HOME/.cargo/bin/
set -gx PATH $PATH $HOME/.npm-global/bin/
set -gx PATH $PATH $HOME/go/bin/
# set -gx PATH $PATH $HOME/anaconda3/bin
set -gx PATH $PATH /usr/local/win/bin
set -gx PATH $PATH $HOME/.juliaup/bin
set -gx PATH $PATH $HOME/snap/bin
