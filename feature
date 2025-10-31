rm -rf /Library/Arturia/Shared/features.xml
echo "<features><product name=\"Efx AMBIENT\"><feature name=\"EngineControls\" enable=\"$1\"/></product></features>" > /Library/Arturia/Shared/features.xml