#!/bin/bash
echo 'Set up gxshell...'
cp /gluex_install/gxshell/gxshell /usr/local/bin/gxshell
cp /gluex_install/gxshell/gluex-env.sh /etc/gluex-env.sh
cp /gluex_install/gxshell/10-docker2singularity.sh /.singularity.d/env/10-docker2singularity.sh
cp /gluex_install/gxshell/99-zz_cntrenv.sh /.singularity.d/env/99-zz_cntrenv.sh
echo '...done!'