import PackagePlugin
import Foundation

@main
struct CreateArtifactBundlPlugine: CommandPlugin {    
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        let createBundleTool = try context.tool(named: "CreateArtifactBundle")
        let createBundleToolURL = URL(fileURLWithPath: createBundleTool.path.string)

        let process = try Process.run(createBundleToolURL, arguments: ["full-flow"] + arguments)
        process.waitUntilExit()
    }
}