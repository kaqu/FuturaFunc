// swift-tools-version:4.1

import PackageDescription

let package = Package(
    name: "FuturaFunc",
    products: [
        .library(
            name: "FuturaFunc",
            targets: ["FuturaFunc"]),
    ],
    dependencies: [
         .package(url: "https://github.com/kaqu/FuturaAsync.git", from: "0.9.0"),
    ],
    targets: [
        .target(
            name: "FuturaFunc",
            dependencies: ["FuturaAsync"]),
        .testTarget(
            name: "FuturaFuncTests",
            dependencies: ["FuturaAsync","FuturaFunc"]),
    ]
)
