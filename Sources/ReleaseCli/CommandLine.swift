import Foundation

extension CommandLine {
    struct Option {
        let commandArgument: String
        let valueArgument: String?
    }

    static func option(for commandArgument: String) -> Option? {
        guard let commandIndex = CommandLine.arguments.firstIndex(of: commandArgument) else {
            return nil
        }
        let valueArgument = CommandLine.arguments.element(after: commandIndex)
        return Option(commandArgument: commandArgument, valueArgument: valueArgument)
    }
}