#!/bin/bash

function create_script {
    gt=`echo $gluex_top | sed -e 's./.\\\\/.g'`
    sed -e "s/<gluex-top>/${gt}/" < $gi_path/$name.template > $1
}

gi_script="${BASH_SOURCE[0]}";
if([ -h "${gi_script}" ]) then
  while([ -h "${gi_script}" ]) do gi_script=`readlink "${gi_script}"`; done
fi
cd `dirname ${gi_script}`
gi_path=`pwd`
gluex_top=$1
cd $gluex_top
for name in gluex_env_boot.sh gluex_env_boot.csh gluex_env_local.sh gluex_env_local.csh; do
    echo creating script $name
    create_script $name
done
