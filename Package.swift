// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "create-artifact-bundle",
    platforms: [.macOS(.v11), .iOS(.v11)],
    products: [
        .executable(name: "CreateArtifactBundle", targets: ["CreateArtifactBundle"]),
        .plugin(name: "CreateArtifactBundlePlugin", targets: ["CreateArtifactBundlePlugin"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
        .package(url: "https://github.com/aleksproger/create-artifact-bundle-kit.git", from: "2.0.0"),
    ],
    targets: [
        .executableTarget(name: "CreateArtifactBundle", dependencies: [
            .product(name: "CreateArtifactBundleKit", package: "create-artifact-bundle-kit"),
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
        ]),

        .plugin(
            name: "CreateArtifactBundlePlugin",
            capability: .command(
                intent: .custom(
                    verb: "create-artifact-bundle",
                    description: "Create artifact bundle from the package."
                ),
                permissions: [
                    .writeToPackageDirectory(reason: "Need to create bundle structure.")
                ]
            ),
            dependencies: ["CreateArtifactBundle"]
        ),
    ]
)
