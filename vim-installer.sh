
#!/bin/bash -e

echo "install lua"
sudo apt-get -y install liblua5.2-dev lua5.2

echo "download vim"

WORK_DIR="vim-build"
INSTALL_DIR="${HOME}/usr"

rm -rf $WORK_DIR
rm -rf $INSTALL_DIR

mkdir -p $WORK_DIR
mkdir -p $INSTALL_DIR

cd $WORK_DIR
wget ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
tar xvf vim-7.4.tar.bz2
cd vim74/

echo "build vim"

./configure \
 --enable-multibyte \
 --with-features=huge \
 --prefix=${INSTALL_DIR} \
 --enable-luainterp=yes \
 --enable-perlinterp \
 --enable-pythoninterp \
 --with-python-config-dir=/usr/lib64/python2.6/config \
 --enable-rubyinterp \
 --with-ruby-command=/usr/bin/ruby

make
./src/vim --version | grep lua

make install

echo "alias vim=\"$HOME/usr/bin/vim\"" >> $HOME/.bashrc
exec $SHELL -l
