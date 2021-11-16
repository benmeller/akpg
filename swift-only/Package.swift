// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-cli",
    platforms: [
       .macOS(.v10_13), .iOS(.v11),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        // .package(url: "https://github.com/apple/swift-package-manager.git", from: "0.3.0"),
        .package(url: "https://github.com/AudioKit/SoundpipeAudioKit.git", from: "5.0.0"),
        .package(url: "https://github.com/AudioKit/DunneAudioKit", from: "5.2.2"),
        .package(url: "https://github.com/AudioKit/AudioKit.git", from: "5.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "synth",
            dependencies: ["SoundpipeAudioKit", "AudioKit", "DunneAudioKit"]),
        // .testTarget(
        //     name: "swift-cliTests",
        //     dependencies: ["swift-cli"]),
    ]
)
