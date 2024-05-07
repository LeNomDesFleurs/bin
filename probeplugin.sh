#!/bin/bash

PLUGIN_NAME=$1

AU_PLUGIN_PATH=/Library/Audio/Plug-Ins/Components/"$PLUGIN_NAME".component

if [ -d "$AU_PLUGIN_PATH" ]; then
    echo "au found in system library"
fi
AU_PLUGIN_PATH=~/Library/Audio/Plug-Ins/Components/"$PLUGIN_NAME".component

if [ -d "$AU_PLUGIN_PATH" ]; then
    echo "au found in user library"
fi

VST3_PLUGIN_PATH=/Library/Audio/Plug-Ins/VST3/"$PLUGIN_NAME".vst3

if [ -d "$VST3_PLUGIN_PATH" ]; then
    echo "vst3 found in system library"
fi

VST3_PLUGIN_PATH=~/Library/Audio/Plug-Ins/VST3/"$PLUGIN_NAME".vst3
# VST3_PLUGIN_PATH=/Users/thomas/Library/Audio/Plug-Ins/VST3/Sinensis.vst3

if [ -d "$VST3_PLUGIN_PATH" ]; then   
    echo "vst3 found in user library"
fi