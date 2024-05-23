#
# variable
#
set --export DROPBOX "$HOME/Dropbox"
set --export ONEDRIVE "$HOME/OneDrive"
set --export brc "$HOME/.bashrc"
set --export zrc "$HOME/.zshrc"
set --export nvim "$DROPBOX/dotfiles/config/nvim"
set --export lazy "$HOME/.local/share/nvim/lazy"
# set --export fish "$DROPBOX/dotfiles/config/fish"
set --export fish "$HOME/.config/fish"

set --export EDITOR nvim
set --export VIMTEX_OUTPUT_DIRECTORY build
set --export BROWSER firefox
set --export JAVA_HOME /usr/lib/jvm/java-21-openjdk/
set --export DENO_INSTALL "/home/shion/.deno"

#easifem-dev related 
set --export easifem "$DROPBOX/easifem"
set --export base "$easifem/base"
set --export classes "$easifem/classes"
set --export elasticity "$easifem/elasticity"
set --export acoustic $easifem/acoustic
set --export ere $HOME/easifem-results
set --export easifemdocs $easifem/easifem.github.io
set --export docs $easifem/easifem.github.io/docs/docs-api
set --export lec $easifem/lectures/docs
set --export OMP_NUM_THREADS 1
set --export OPENBLAS_NUM_THREADS 1
# NOTE: In addition to following extra paths 
# one symlink to libgmsh.so.x.xx.x should be made 
# in $HOME/.easifem/install/easifem/extpkgs/lib 
set -gx GMSH_LIB $HOME/.local/lib/
set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH $HOME/.local/lib
set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH /usr/local/lib

# gtk dark 
# NOTE: following variables are written in /etc/environment
# set --export GTK_THEME Adwaita:dark
# set --export GTK2_RC_FILES /usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
# set --export QT_STYLE_OVERRIDE Adwaita-dark

# sci lab 
set --export SCI /usr/share/scilab/

set -gx PATH $PATH $DENO_INSTALL/bin
set -gx PATH $PATH /opt/ParaView/bin/
set -gx PATH $PATH $HOME/.cargo/bin/
set -gx PATH $PATH $HOME/.npm-global/bin/
set -gx PATH $PATH $HOME/go/bin/
# set -gx PATH $PATH $HOME/anaconda3/bin
set -gx PATH $PATH /usr/local/win/bin
