import ShellOut

/// Convenience wrapper to allow skipping of param names when this function is called
@discardableResult public func exec(
  _ command: ShellOutCommand,
  _ path: String = "."
) throws -> String {
    return try shellOut(
        to: command.string,
        at: path
    )
}

public extension ShellOutCommand {

    static func gitFetch() -> ShellOutCommand {
        let command = "git -c http.sslverify=false fetch";

        return ShellOutCommand(string: command)
    }

    static func gitLastCommitId(remote: String? = nil) -> ShellOutCommand {
        var command = "git -c http.sslverify=false rev-parse";

        if remote != nil {
          command.append(" \(remote!)")
        }

        return ShellOutCommand(string: command)
    }

    static func gitLog(tag: String? = nil, remote: String? = nil, reverse: Bool = true) -> ShellOutCommand {
        var command = "git -c http.sslverify=false log --oneline";
        
        if remote != nil {
          command.append(" \(remote!)")
        }
        
        if reverse {
          command.append(" --reverse")
        }

        if tag != nil {
          command.append(" \(tag!)..HEAD")
        }

        return ShellOutCommand(string: command)
    }

    static func gitFindTagOnRemote(tag: String? = nil, remote: String? = nil)  -> ShellOutCommand {
        var command = "git -c http.sslverify=false ls-remote --tags";

        if remote != nil {
          command.append(" \(remote!.replacingOccurrences(of: "/", with: " "))")
        }

        if tag != nil {
          command.append(" refs/tags/\(tag!)")
        }

        return ShellOutCommand(string: command)
    }
}
