import ArgumentParser
import CreateArtifactBundleKit

extension CreateArtifactBundleCommand {
    struct XCFrameworkFlow: AsyncParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "xcframework",
            abstract: "Create artifact bundle from XCFramework",
            discussion: "Create an artifact bundle from provided XCFramework."
        )

        @Option(help: "Path to the xframework.")
        var path: String

        @Option(help: "Version of the artifact bundle.")
        var version: String

        @Option(help: "Output directory for artifact bundle.")
        var outputDirectory: String = "."


        func run() async throws {
            let configuration = XCFrameworkConfiguration(
                xcframework: path,
                version: version,
                outputDirectory: outputDirectory
            )

            try await Kits
                .prebuiltBinariesFlow()
                .run(with: configuration)
        }
    }
}
