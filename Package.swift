// swift-tools-version:4.1

import PackageDescription

let package = Package(
    name: "FuturaFunc",
    products: [
        .library(
            name: "FuturaFunc",
            targets: ["FuturaFunc"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "FuturaFunc",
            dependencies: []),
        .testTarget(
            name: "FuturaFuncTests",
            dependencies: ["FuturaFunc"]),
    ]
)
