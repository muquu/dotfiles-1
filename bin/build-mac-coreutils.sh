#!/bin/sh
. "`dirname -- "$0"`"/functions.sh || exit

# Mac only
is_mac || exit 1

# install
brew install xz binutils coreutils findutils

# create startup script
( echo "# generated by $DOTFILES_DIR/bin/$(basename -- "$0")"
  echo '# coreutils'
  echo 'export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"'
  echo '# findutils'
  echo 'alias find=gfind'
  echo 'alias xargs=gxargs'
) | make_profile_script 10-mac-coreutils.sh
