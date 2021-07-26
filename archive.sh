# BUILD=$1      # PARAM-1 for specifying scheme either Debug / Release
# IPA_PATH=$2   # PARAM-2 for specifying IPA Path to export it
#
# if [ "$BUILD" = "debug" ]; then
#     SCHEME="BreakingBadDebug"
#     CONFIG_PATH="BreakingBadDebug/Config/Debug/export.plist"
# else
#     SCHEME="BreakingBadRelease"
#     CONFIG_PATH="BreakingBadRelease/Config/Release/export.plist"
# fi
#
# xcodebuild archive -workspace BreakingBad.xcworkspace -scheme $SCHEME -archivePath Archive/BreakingBad.xcarchive
# xcodebuild -exportArchive -archivePath Archive/BreakingBad.xcarchive -exportPath $IPA_PATH -exportOptionsPlist $CONFIG_PATH
