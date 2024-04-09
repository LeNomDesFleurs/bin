#!/bin/bash  
echo ""
echo "=============================================================================================================="
echo "====              Code signing and notarisation script                                                    ===="
echo "=============================================================================================================="
echo "====                                                                                                      ===="
echo "====     Usage:                                                                                           ===="
echo "====     ./createPkgs.sh PluginName DeveloperId AppleID AppPass Identifier Version                        ===="
echo "====                                                                                                      ===="
echo "====     PluginName = Plugin name without any extension - will try to create pkgs for VST/VST3/AU         ===="
echo "====     Developer ID = \"Your Name (NNNNNNNNNN)\"                                                        ===="
echo "====     Apple ID = emailaddress@somewhere.com                                                            ===="
echo "====     AppPass = app-sepecific password generate at  https://appleid.apple.com/                         ===="
echo "====     Identifier  = com.MyCompany.name                                                                 ===="
echo "====     Version  = version number, i.e, 1.0.1                                                            ===="
echo "=============================================================================================================="
echo ""
if [ "$EUID" -ne 0 ]
  then echo "Error: Please run this command as root using sudo..."
  echo ""
  exit
fi	

# if [[ $# -lt 4 ]]; then
#     echo "Error: Illegal number of parameters..."
#     echo ""
#     exit
# fi

PLUGIN_NAME=$1
DEVELOPER_ID=$2
# APP_PASS=$3
# APPLE_ID=$4
IDENTIFIER=$5
VERSION=$6

#use pkgbuild to build the  plugin installers - and sign with Apple Developer ID 
pkgbuild --install-location /Library/Audio/Plug-Ins/Components --identifier "$IDENTIFIER"au --version 1.0.2 --component "$PLUGIN_NAME.component" "$PLUGIN_NAME"_au.pkg 
sudo codesign -s "Developer ID Application: $DEVELOPER_ID" "$PLUGIN_NAME".component --timestamp --force --deep
pkgbuild --install-location /Library/Audio/Plug-Ins/VST3 --identifier "$IDENTIFIER"vst3 --version 1.0.2 --component "$PLUGIN_NAME".vst3 "$PLUGIN_NAME"vst3.pkg 
sudo codesign -s "Developer ID Application: $DEVELOPER_ID" "$PLUGIN_NAME".vst3 --timestamp --force --deep
productbuild --synthesize --package "$PLUGIN_NAME"_au.pkg --package "$PLUGIN_NAME"_vst3.pkg distribution.xml
productbuild --distribution distribution.xml --resources Resources/ ""$PLUGIN_NAME".pkg"
productsign --sign "Developer ID Installer: $DEVELOPER_ID" "$PLUGIN_NAME".pkg "$PLUGIN_NAME"_installer.pkg
xcrun notarytool submit --keychain-profile "thomas" "$PLUGIN_ID".pkg
xcrun stapler staple "$PLUGIN_ID".pkg