// swift-tools-version: 5.8

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "concurrency_ground",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "concurrency_ground",
            targets: ["AppModule"],
            bundleIdentifier: "jp.kiroru.concurrency-ground",
            teamIdentifier: "Y48P6SY25X",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .chatMessage),
            accentColor: .presetColor(.indigo),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", "1.9.3"..<"2.0.0")
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ],
            path: "."
        )
    ]
)