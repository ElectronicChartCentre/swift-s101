// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-s101",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(
            name: "SwiftS101",
            targets: ["SwiftS101"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ElectronicChartCentre/swift-iso8211", from: "0.0.1"),
        //.package(path: "../swift-iso8211"),
        .package(url: "https://github.com/ElectronicChartCentre/swift-geo", from: "0.0.3"),
        //.package(path: "../swift-geo"),
        .package(url: "https://github.com/apple/swift-collections.git", from: "1.3.0"),
        // zip only needed for testing
        .package(url: "https://github.com/adam-fowler/swift-zip-archive", from: "0.6.4")
    ],
    targets: [
        .target(
            name: "SwiftS101",
            dependencies: [
                .product(name: "SwiftISO8211", package: "swift-iso8211"),
                .product(name: "SwiftGeo", package: "swift-geo"),
                .product(name: "Collections", package: "swift-collections")
            ]
        ),
        .testTarget(
            name: "SwiftS101Tests",
            dependencies: [
                .target(name: "SwiftS101"),
                .product(name: "ZipArchive", package: "swift-zip-archive")
            ],
            resources: [.copy("TestResources")]
        ),
    ]
)
