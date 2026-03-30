// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "TinySwift",
    platforms: [
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v4)
    ],
    products: [
        .library(
            name: "TinySwift",
            targets: ["TinySwift"]
        )
    ],
    targets: [
        .target(
            name: "TinySwift",
            path: "TinySwift"
        ),
        .testTarget(
            name: "TinySwiftTests",
            dependencies: ["TinySwift"],
            path: "Example/Tests",
            exclude: ["Info.plist"],
            resources: [
                .process("land.jpg"),
                .process("View.xib")
            ]
        )
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
