
#!/bin/bash -e

echo "install lua"
sudo apt-get -y install liblua5.2-dev lua5.2 unzip htop 

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

make -j2
./src/vim --version | grep lua

make install

echo "alias vim=\"$HOME/usr/bin/vim\"" >> $HOME/.bashrc
exec $SHELL -l

git clone https://github.com/ieee0824/dotfiles.git $HOME/.dotfiles

echo "install mysql tuner"
mkdir -p $INSTALL_DIR/bin
cd $INSTALL_DIR/bin
wget -O mysqltuner.zip https://github.com/rackerhacker/MySQLTuner-perl/archive/master.zip
unzip mysqltuner.zip
rm mysqltuner.zip
cd MySQLTuner-perl-master
chmod +x mysqltuner.pl

echo "mysql のバックアップをとる"
echo "nginx のバックアップをとる"
echo "アプリケーションのバックアップをとる"


