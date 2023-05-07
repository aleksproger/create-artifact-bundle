import ArgumentParser
import CreateArtifactBundleKit
import Foundation

@main
struct CreateArtifactBundleCommand: AsyncParsableCommand {
    static var configuration: CommandConfiguration = CommandConfiguration(
        commandName: "create-artifact-bundle",
        abstract: "Create artifact bundle from package target/prebuilt binaries/XCFramework.",
        subcommands: [
            FullFlow.self,
            PrebuiltBinariesFlow.self,
        ],
        defaultSubcommand: FullFlow.self
    )
}