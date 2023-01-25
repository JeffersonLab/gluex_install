#!/bin/bash
echo 'Set up gxshell...'
cp /gluex_install/gxshell/gxshell /usr/local/bin/gxshell
cp /gluex_install/gxshell/gluex-env.sh /etc/gluex-env.sh
mkdir -p /.singularity.d/env/ #needed for Docker, no harm done for singularity, but not very elegant
cp /gluex_install/gxshell/99-zz_cntrenv.sh /.singularity.d/env/99-zz_cntrenv.sh
echo '...done!'