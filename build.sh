xcodebuild -workspace BreakingBad.xcworkspace -scheme BreakingBadDebug
xcodebuild -workspace BreakingBad.xcworkspace -scheme BreakingBadDebug -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 12,OS=14.5' test | xcpretty color
