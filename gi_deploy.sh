#!/bin/bash
webdir=/group/halld/www/halldweb/html/dist
tardir=/tmp/gi_deploy
giturl=https://github.com/markito3/gluex_install.git
mkdir -pv $tardir
cd $tardir
rm -rf gluex_install
git clone $giturl
tar cvf gluex_install.tar gluex_install --exclude gluex_install/.git
cd $webdir
mv -v gluex_install.tar gluex_install.tar.bak
cp -pv $tardir/gluex_install.tar .
exit
