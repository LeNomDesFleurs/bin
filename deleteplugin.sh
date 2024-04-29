#!/bin/bash 

PLUGIN_NAME=$1

rm -rfv /Library/Audio/Plug-Ins/Components/"$PLUGIN_NAME".component
rm -rfv ~/Library/Audio/Plug-Ins/Components/"$PLUGIN_NAME".component
rm -rfv /Library/Audio/Plug-Ins/VST3/"$PLUGIN_NAME".vst3
rm -rfv ~/Library/Audio/Plug-Ins/VST3/"$PLUGIN_NAME".vst3


echo "try to delete a plugin in user and system directories, for au and vst3"
echo "provide the name of the the plugin in argument, whitout extension"