#!/usr/bin/env bash
# usage:
#   ./install.sh new/path/to/install
# example
#   ./install.sh .v2.4.0

SCRIPTNAME="$0"
INSTALL_PATH="$1"

DIRNAME=$(readlink -f $(dirname $0))


mkdir -p ${INSTALL_PATH}


if [ -n "$(ls -A $INSTALL_PATH 2>/dev/null)" ]
then
    echo "ERROR: directory not empty: ${INSTALL_PATH}"
    exit 1
fi

# copy essential files & directories

## carlisle CLI script
cp $DIRNAME/carlisle $INSTALL_PATH/

## all config & workflow scripts;
for subdir in config workflow/scripts
do  
    mkdir -p ${INSTALL_PATH}/$subdir
    cp ${DIRNAME}/$subdir/* ${INSTALL_PATH}/$subdir
done

## selected resources
mkdir -p ${INSTALL_PATH}/resources/
cp ${DIRNAME}/resources/*.yaml ${INSTALL_PATH}/resources/

# export path
if [[ ":$PATH:" != *":${INSTALL_PATH}:"* ]];then
    export PATH="${PATH}:${INSTALL_PATH}"
fi
