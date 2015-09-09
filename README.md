# Google-Place-AutoComplete

For finding all the cities ,google is providing place_Autocomplete.
STEPS:
Step-1:Create a xcode project
Step-2:Open Terminal for adding frameworks using CocoaPods.If u will add directly to the project it will show an error of NSThread...
Step:3:change the directory to where your .xcodeproj file present.
       Type: sudo gem install cocoapods     for installing
      Then type:   nano Podfile
      Then type:   cat Podfile
                    source 'https://github.com/CocoaPods/Specs.git'
                    platform :ios, '8.1'
                    pod 'GoogleMaps'
      Then type :pod install
Step-4:After that your pod is installed successfully.
Step-5:Open .xcworkspace
