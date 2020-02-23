import ShellOut
import Foundation

guard let remoteBranch: String = CommandLine.option(for: "--remote")?.valueArgument else {
    throw CliErrors.argumentNotFound
}

guard let tagName: String = CommandLine.option(for: "--tag")?.valueArgument else {
    throw CliErrors.argumentNotFound
}

guard let projects: [String] = CommandLine.option(for: "--projects")?.valueArgument?.components(separatedBy: ",") else {
    throw CliErrors.argumentNotFound
}

func getStoriesSinceTag(for projects: [String], with tag: String, on remoteBranch: String) throws -> [ProjectStories] {
    return try projects.map {
        let gitFolder: String = "./\($0)"

        /*
         * To ensure that we get all of the commits after a particular tag, we
         * need to make sure that we have the full commit history from the remote
         * 
         * Note: This command will throw on connectivity issues or if the path is not found
         */
        try exec(.gitFetch(), gitFolder)

        let lastCommitIdOnRemote = try exec(.gitLastCommitId(remote: remoteBranch), gitFolder)
        let isDeployedToDevOnRemote: Bool = try exec(.gitFindTagOnRemote(tag: "dev", remote: remoteBranch), gitFolder).contains(lastCommitIdOnRemote)
        let isDeployedToTestOnRemote: Bool = try exec(.gitFindTagOnRemote(tag: "test", remote: remoteBranch), gitFolder).contains(lastCommitIdOnRemote)
        let isDeployedToUATOnRemote: Bool = try exec(.gitFindTagOnRemote(tag: "uat", remote: remoteBranch), gitFolder).contains(lastCommitIdOnRemote)
        let isDeployedToProdOnRemote: Bool = try exec(.gitFindTagOnRemote(tag: "prod", remote: remoteBranch), gitFolder).contains(lastCommitIdOnRemote)

        /*
         * The following will return a single line for each of the commits on the 
         * remote since the one that was tagged with the string we are searching for
         * 
         * Note: This command will throw when the tag does not exist on the remote
         */
        let commitHistorySinceTag = try exec(.gitLog(tag: tag, remote: remoteBranch), gitFolder)

        return ProjectStories(
            project: $0,
            lastCommitId: lastCommitIdOnRemote,
            stories: commitHistorySinceTag.storyNumbers(),
            isDeployedToDev: isDeployedToDevOnRemote,
            isDeployedToTest: isDeployedToTestOnRemote,
            isDeployedToUAT: isDeployedToUATOnRemote,
            isDeployedToProd: isDeployedToProdOnRemote
        )
    }
}

do {
    print(try getStoriesSinceTag(for: projects, with: tagName, on: remoteBranch).asMarkdownTable())
} catch {
    print("Unexpected error: \(error)")
}