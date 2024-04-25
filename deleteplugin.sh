#!/bin/bash 

PLUGIN_NAME=$1

rm /Library/Audio/Plug-Ins/Components/"$PLUGIN_NAME".component
rm ~/Library/Audio/Plug-Ins/Components/"$PLUGIN_NAME".component
rm /Library/Audio/Plug-Ins/Components/"$PLUGIN_NAME".vst3
rm ~/Library/Audio/Plug-Ins/Components/"$PLUGIN_NAME".vst3
