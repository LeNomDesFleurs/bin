#!/bin/bash  
echo ""
echo "=============================================================================================================="
echo "====              Code signing and notarisation script                                                    ===="
echo "=============================================================================================================="
echo "====                                                                                                      ===="
echo "====     Usage:                                                                                           ===="
echo "====     ./distribute.sh PluginName DeveloperId Identifier Version                                        ===="
echo "====     Exemple:                                                                                         ===="
echo "====     ./distribute.sh Synthy \"Jon Doe (53B7GD2XBM)\" com.Doe.name 1.0.1                                 ===="
echo "====                                                                                                      ===="
echo "====     PluginName = Plugin name without any extension - will try to create pkgs for VST/VST3/AU         ===="
echo "====     Developer ID = \"Your Name (NNNNNNNNNN)\"                                                        ===="
echo "====     Identifier  = com.MyCompany.name                                                                 ===="
echo "====     Version  = version number, i.e, 1.0.1                                                            ===="
echo "=============================================================================================================="
echo ""


if [[ $# -lt 4 ]]; then
    echo "Error: Illegal number of parameters..."
    echo ""
    exit
fi



PLUGIN_NAME=$1
DEVELOPER_ID=$2
IDENTIFIER=$3
VERSION=$4
USER_AU_PATH=~/Library/Audio/Plug-Ins/Components/
USER_VST3_PATH=~/Library/Audio/Plug-Ins/VST3/
SYSTEM_AU_PATH=/Library/Audio/Plug-Ins/Components/
SYSTEM_VST3_PATH=/Library/Audio/Plug-Ins/VST3/


# echo "$PWD"/"$PLUGIN_NAME".component

# sign the AU binary
codesign -s "Developer ID Application: $DEVELOPER_ID" --timestamp --force -o runtime -i "$USER_AU_PATH""$PLUGIN_NAME".component "$USER_AU_PATH""$PLUGIN_NAME".component/Contents/MacOS/"$PLUGIN_NAME"  #--options=runtime
# package the .content and sign it
pkgbuild --install-location "$SYSTEM_AU_PATH" --sign "Developer ID Installer: $DEVELOPER_ID" --timestamp --identifier "$IDENTIFIER"au --version "$VERSION" --component "$USER_AU_PATH""$PLUGIN_NAME".component "$PLUGIN_NAME"_au.pkg 
# sign the VST binary
codesign -s "Developer ID Application: $DEVELOPER_ID" --timestamp --force -o runtime -i "$USER_VST3_PATH""$PLUGIN_NAME".vst3 "$USER_VST3_PATH""$PLUGIN_NAME".vst3/Contents/MacOS/"$PLUGIN_NAME"  #--options=runtime
# package the .vst3 and sign it
pkgbuild --install-location "$SYSTEM_VST3_PATH" --sign "Developer ID Installer: $DEVELOPER_ID" --timestamp --identifier "$IDENTIFIER"vst3 --version "$VERSION" --component "$USER_VST3_PATH""$PLUGIN_NAME".vst3 "$PLUGIN_NAME"_vst3.pkg 
# prepare the installer
productbuild --synthesize --package "$PLUGIN_NAME"_au.pkg --package "$PLUGIN_NAME"_vst3.pkg distribution.xml
# build the installer
productbuild --distribution distribution.xml --resources Resources/ "$PLUGIN_NAME".pkg
# Sign the installer
productsign --sign "Developer ID Installer: $DEVELOPER_ID" "$PLUGIN_NAME".pkg "$PLUGIN_NAME"_installer.pkg --timestamp
# notarize the installer for gatekeeper
xcrun notarytool submit --keychain-profile "thomas" "$PLUGIN_NAME"_installer.pkg --wait
# staple the ticket to the installer
xcrun stapler staple "$PLUGIN_NAME"_installer.pkg

CLEAN=true

while getopts ":dont-clean:" option; do
  case $option in
    dont-clean)
      CLEAN=false
      ;;
  esac
done

if [$CLEAN]
then
# clean
rm distribution.xml
rm "$PLUGIN_NAME".pkg
rm "$USER_AU_PATH""$PLUGIN_NAME"_au.pkg
rm "$USER_VST_PATH""$PLUGIN_NAME"_vst3.pkg
fi