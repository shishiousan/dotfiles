#
# variable
#

# fish 
# suppress reflow when the terminal is resized 
set -gx fish_handle_reflow 0

set --export DROPBOX "$HOME/Dropbox"
set --export ONEDRIVE "$HOME/OneDrive"
set --export MYNAS_LOCAL "$HOME/Nasync/shionLab/"
set --export MYNAS_REMOTE /mnt/nas/
set --export brc "$HOME/.bashrc"
set --export zrc "$HOME/.zshrc"
# set --export nvim "$DROPBOX/dotfiles/config/nvim"
set --export nvim "$DROPBOX/src/PengVim"
set --export pengvim "$DROPBOX/src/PengVim"
set --export lazy "$HOME/.local/share/nvim/lazy"
# set --export fish "$DROPBOX/dotfiles/config/fish"
set --export fish "$HOME/.config/fish"
set --export config "$HOME/.config"
set --export dotfiles "$DROPBOX/dotfiles"
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
set --export elasticity "$easifem/elasticityKernel"
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
set --export EASIFEM_LINT_OPTIONS (cat $fish/easifem_lint_options.txt 2>/dev/null)

# fzf 
set -gx TMUX_FZF_OPTIONS '-p 80%'
## nightfly scheme
set -gx FZF_DEFAULT_OPTS --color=bg:#011627,bg+:#0e293f,border:#2c3043,fg:#acb4c2,fg+:#d6deeb,gutter:#0e293f,header:#82aaff,hl+:#f78c6c,hl:#f78c6c,info:#ecc48d,marker:#f78c6c,pointer:#ff5874,prompt:#82aaff,spinner:#21c7a8
set -gx FZF_DEFAULT_OPTS $FZF_DEFAULT_OPTS "--height=50% --reverse --preview='bat --color=always {}'"
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

# intel HPC toolkit related
set -gx PATH $PATH /opt/intel/oneapi/compiler/2025.1/bin/
set -gx LD_LIBRARY_PATH /opt/intel/oneapi/mkl/2025.1/lib $LD_LIBRARY_PATH
