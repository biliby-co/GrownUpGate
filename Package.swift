// swift-tools-version: 5.9
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
    dependencies: [
    ],
    targets: [
        .target(
            name: "GrownUpGate",
            dependencies: []),
        .testTarget(
            name: "GrownUpGateTests",
            dependencies: ["GrownUpGate"]),
    ]
)
