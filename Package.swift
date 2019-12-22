// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "SwiftySound",
    products: [
        .library(
            name: "SwiftySound",
            targets: ["SwiftySound"])
    ],
    targets: [
        .target(
            name: "SwiftySound",
            path: "Sources")
    ],
    swiftLanguageVersions: [.v5]
)
