// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SwiftyJSONOverTCP",
    products: [
        .library(name: "SwiftyJSONOverTCP", targets: ["SwiftyJSONOverTCP"]),
    ],
    targets: [
        .target(name: "SwiftyJSONOverTCP"),
        .testTarget(name: "SwiftyJSONOverTCPTests", dependencies: ["SwiftyJSONOverTCP"]),
    ]
)
