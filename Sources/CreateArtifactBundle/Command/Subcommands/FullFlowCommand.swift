import ArgumentParser
import CreateArtifactBundleKit

extension CreateArtifactBundleCommand {
    struct FullFlow: AsyncParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "full-flow",
            abstract: "Creates artifact bundle from the macOS executable target",
            discussion: "When no files are specified, it expects the source from standard input."
        )

        @Option(help: "Name of the executable target to create the artifact bundle for.")
        var target: String

        /// Swift pluigns arguments parsing bug requires to use `_` prefix
        @Option(name: .customLong("version", withSingleDash: false), help: "Version of the artifact bundle.")
        var _version: String

        @Option(help: "Output directory for artifact bundle.")
        var outputDirectory: String = "."

        @Option(help: "Directory of the Swift package which contains the target.")
        var packageDirectory: String = "."

        @Option(help: "Build directory.")
        var buildDirectory: String = ".build"

        @Option(help: "MacOS triples to build for.")
        var triple: [MacOSTriple]

        func run() async throws {
            let configuration = FullFlowConfiguration(
                target: target,
                version: _version,
                outputDirectory: outputDirectory,
                variants: [
                    /// For now only macOS supported for full flow
                    "macosx": Set(triple.map(\.rawValue)),
                ],
                buildDirectory: buildDirectory,
                packageDirectory: packageDirectory
            )

            try await Kits
                .fullFlow()
                .run(with: configuration)
        }
    }
}

enum MacOSTriple: String, ExpressibleByArgument {
    case arm64 = "arm64-apple-macosx"
    case x86_64 = "x86_64-apple-macosx"
}