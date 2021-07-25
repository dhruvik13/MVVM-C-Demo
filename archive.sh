# BUILD=$1      # PARAM-1 for specifying scheme either Debug / Release
# IPA_PATH=$2   # PARAM-2 for specifying IPA Path to export it

# if [ "$BUILD" = "debug" ]; then
#     SCHEME="TestBuildAppDebug"
#     CONFIG_PATH="TestBuildApp/Config/Debug/export.plist" 
# else
#     SCHEME="TestBuildAppRelease"
#     CONFIG_PATH="TestBuildApp/Config/Release/export.plist"
# fi

# xcodebuild archive -project <name.xcproj> -scheme $SCHEME -archivePath Archive/Test.xcarchive
# xcodebuild -exportArchive -archivePath Archive/Test.xcarchive -exportPath $IPA_PATH -exportOptionsPlist $CONFIG_PATH