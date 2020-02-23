class ProjectStories {
    let project: String
    let lastCommitId: String
    let isDeployedToDev: Bool
    let isDeployedToTest: Bool
    let isDeployedToUAT: Bool
    let isDeployedToProd: Bool
    let stories: [String]

    init(
      project: String,
      lastCommitId: String,
      stories: [String],
      isDeployedToDev: Bool,
      isDeployedToTest: Bool,
      isDeployedToUAT: Bool,
      isDeployedToProd: Bool) {

      self.project = project
      self.lastCommitId = lastCommitId
      self.stories = stories
      self.isDeployedToDev = isDeployedToDev
      self.isDeployedToTest = isDeployedToTest
      self.isDeployedToUAT = isDeployedToUAT
      self.isDeployedToProd = isDeployedToProd
    }
}