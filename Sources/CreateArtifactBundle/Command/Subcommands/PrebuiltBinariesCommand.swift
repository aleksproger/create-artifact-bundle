import ArgumentParser
import CreateArtifactBundleKit

extension CreateArtifactBundleCommand {
    struct PrebuiltBinariesFlow: AsyncParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "prebuilt-binaries",
            abstract: "Create artifact bundle from prebuilt binaries",
            discussion: "When no files are specified, it expects the source from standard input."
        )

        @Option(help: "Name of the executable target to create the artifact bundle for.")
        var target: String

        @Option(help: "Version of the artifact bundle.")
        var version: String

        @Option(help: "Directory of the Swift package which contains the target.")
        var outputDirectory: String = "."

        @Option(help: "Directory of the Swift package which contains the target.")
        var variant: [ArgumentVariant]

        func run() async throws {
            let configuration = PrebuiltBinariesConfiguration(
                target: target,
                version: version,
                outputDirectory: outputDirectory,
                variants: prebuiltVariants(variant)
            )

            try await Kits
                .prebuiltBinariesFlow()
                .run(with: configuration)
        }
    }
}

struct ArgumentVariant {
    let name: String
    let triple: String
    let path: String
}

extension ArgumentVariant: ExpressibleByArgument {
    public init?(argument: String) {
        let components = argument.components(separatedBy: ":")
        guard components.count == 3 else { return nil }
        self.init(name: components[0], triple: components[1], path: components[2])
    }
}

private func prebuiltVariants(_ argumentVariants: [ArgumentVariant]) -> [PrebuiltBinariesVariant] {
    let dictionary = Dictionary(grouping: argumentVariants, by: \.name)
    return dictionary.map { (key, value) in
        PrebuiltBinariesVariant(
            name: key,
            binaries: value.map { Binary(triple: $0.triple, path: $0.path) }
        )
    }

}