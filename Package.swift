// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-s101",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftS101",
            targets: ["SwiftS101"]
        ),
    ],
    dependencies: [
        //.package(url: "https://github.com/ElectronicChartCentre/swift-iso8211", from: "1.0.0"),
        .package(path: "../swift-iso8211")
    ],

    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftS101",
            dependencies: [
                .product(name: "SwiftISO8211", package:"swift-iso8211")
            ]
        ),
        .testTarget(
            name: "SwiftS101Tests",
            dependencies: ["SwiftS101"],
            resources: [.copy("TestResources")]
        ),
    ]
)
