import ArgumentParser

@main
struct Musicli: AsyncParsableCommand {
    static var configuration = CommandConfiguration(
        subcommands: [Search.self, Display.self],
        defaultSubcommand: Search.self
    )
}
