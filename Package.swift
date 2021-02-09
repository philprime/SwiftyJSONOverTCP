// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "JSONOverTCP",
    products: [
        .library(name: "JSONOverTCP", targets: ["JSONOverTCP"]),
    ],
    targets: [
        .target(name: "JSONOverTCP"),
        .testTarget(name: "JSONOverTCPTests", dependencies: ["JSONOverTCP"]),
    ]
)
