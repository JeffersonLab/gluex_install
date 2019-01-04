#!/bin/bash

function create_script {
    gt=`echo $gluex_top | sed -e 's./.\\\\/.g'`
    sed -e "s/<gluex-top>/${gt}/" < $gi_path/$name.template > $1
}

gi_path=$1
gluex_top=$2
for name in gluex_env_boot.sh gluex_env_boot.csh gluex_env_local.sh gluex_env_local.csh; do
    echo creating script $name
    create_script $name
done
    
