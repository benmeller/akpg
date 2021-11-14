# swift-cli

Attempting to create a proof of concept without the use of xcode at the moment. 

Between the `swift` command and `Package.swift`, that's all you really need to get up and running.

1. `swift package init --type executable`
1. Add packages to `Package.swift` and note dependencies
    ```
    .package(url: "https://github.com/AudioKit/SoundpipeAudioKit.git", from: "5.0.0"),
    .package(url: "https://github.com/AudioKit/AudioKit.git", from: "5.0.0")
    ```
    ```
    .executableTarget(
            name: "swift-cli",
            dependencies: ["SoundpipeAudioKit", "AudioKit"]),
    ```
1. Specify any extra targets you may want to compile
1. If dependencies complain about macos version, specify 
    ```
    platforms: [
       .macOS(.v10_13), .iOS(.v11),
    ],
    ```
1. Be on your way writing into `main.swift`
1. `swift run <target>`

\<rant\>This is so we can bypass all the crap that xcode (_especially_ Xcode 13) brings with it. I just want to write code and run it, not restart Xcode every 10 mins when it decides not to work..\<\/rant\>
