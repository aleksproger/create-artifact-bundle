# CreateArtifactBundle

Package provides CLI and SwiftPM plugin for creating Artifact Bundles from Swift Packages.

## Info

Proposal regarding Artifact Bundles can be found [here](https://github.com/apple/swift-evolution/blob/main/proposals/0305-swiftpm-binary-target-improvements.md).

Core logic resides in [SDK](https://github.com/aleksproger/create-artifact-bundle-kit.git) package.

## Usage

Package provides `CreateArtifactBundle` CLI which provides three options: 
- Create bundle from target in package
- Create bundle from prebuilt binaries
- Create bundle from XCFramework (for now artifact bundles support only executables and it's more about future direction)

```shell
swift run CreateArtifactBundle full-flow --target CreateArtifactBundle \
--version 1.0.0 \
--triple arm64-apple-macos

swift run CreateArtifactBundle xcframework \
--path <some_path>/<framework_name>.xcframework \
--version 1.0.0

swift run CreateArtifactBundle prebuilt-binaries 
--target SomeShit 
--version 1.0.3 
--variant macosx:arm64-apple-macosx:/usr/local/bin/python3
/// --variant <variant_name>:<variant_arch>:<binary_path> 

```

Also package provides `CreateArtifactBundlePlugin` which is a plugin wrapper around functionality for creating artifact bundle from package target.

```shell
swift package plugin create-artifact-bundle \
--target CreateArtifactBundle \
--version 1.0.0 \
--triple arm64-apple-macos \
--outputDirectory . \
--buildDirectory .build \
--packageDirectory .
```
