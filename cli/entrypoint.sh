#!/bin/sh -l

sh -c "if grep \"^ignore:$BUILD_DIR\" $HOME/ignore; then ls $HOME && exit 0; else ${BUILD_COMMAND:-echo} && netlify $*; fi"
