#!/bin/bash
. "`dirname -- "$0"`"/functions.sh || exit

# MacはMac用のスクリプトを使う
is_mac && exec bash "$DOTFILES_DIR/bin/build-mac-tmux.sh"

src="$DOTFILES_SRC/tmux"
dest="$DOTFILES_DEST/tmux"

# 必要パッケージのチェック
has_rpm_packages automake libevent-devel ncurses-devel || exit 1

# develop version
rm -rf "$src"
git clone git://tmux.git.sourceforge.net/gitroot/tmux/tmux "$src"

# libevent2が必要なので1.xしか無い場合はソースで入れる
if rpm -q libevent-devel-1.\* >/dev/null 2>&1; then
  src2="$DOTFILES_SRC/libevent2"
  dest2="$DOTFILES_DEST/libevent2"
  mkdir -p "$src2" && cd "$src2" || exit 1
  curl -L https://github.com/downloads/libevent/libevent/libevent-2.0.20-stable.tar.gz | tar xz
  cd libevent-2.0.20-stable || exit 1
  ./configure --prefix="$dest2" && make && make install || exit 1
  # create startup script for livevent2
  ( echo "# generated by $DOTFILES_DIR/bin/$(basename -- "$0")"
    echo "export LD_LIBRARY_PATH=\"\$LD_LIBRARY_PATH:$dest2/lib\""
  ) | make_profile_script 10-tmux-libevent2.sh
  # この後のtmuxビルド用に環境変数設定
  export CPPFLAGS="-I$dest2/include"
  export LDFLAGS="-L$dest2/lib"
  export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$dest2/lib"
fi

# install
cd "$src" || exit 1
sh autogen.sh || exit 1
./configure --prefix="$dest" && make && make install || exit 1

# create startup script
( echo "# generated by $DOTFILES_DIR/bin/$(basename -- "$0")"
  echo "export PATH=\"$dest/bin:\$PATH\""
) | make_profile_script 10-tmux.sh
