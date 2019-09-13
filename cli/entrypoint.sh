#!/bin/sh -l

if grep "^ignore:$BUILD_DIR" $HOME/ignore; then
 ls $HOME && exit 0;
else 
 ${BUILD_COMMAND:-echo} && output=$(netlify $*); echo ::set-output name=output::$output;
fi
