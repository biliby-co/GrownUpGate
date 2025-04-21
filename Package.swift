// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GrownUpGate",
    platforms: [
        .iOS(.v15),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "GrownUpGate",
            targets: ["GrownUpGate"]),
    ],
    targets: [
        .target(
            name: "GrownUpGate",
            dependencies: [],
            resources: [
                .process("Resources/AskForHelp.m4a")
            ]
        )
    ]
)
