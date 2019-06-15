// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "SwiftySound",
    products: [
        .library(name: "SwiftySound", targets: ["SwiftySound-iOS"])
    ],
    targets: [
        .target(name: "SwiftySound-iOS", dependencies: [], path: "Sources")
    ]
)
