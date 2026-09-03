// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-sample-comparison",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Sample Comparison",
            targets: ["Sample Comparison"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-sample.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-comparison.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-order.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Sample Comparison",
            dependencies: [
                .product(name: "Sample", package: "swift-sample"),
                .product(name: "Comparison", package: "swift-comparison"),
                .product(name: "Order", package: "swift-order"),
            ]
        ),
        .testTarget(
            name: "Sample Comparison Tests",
            dependencies: ["Sample Comparison"],
            path: "Tests/Sample Comparison Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
