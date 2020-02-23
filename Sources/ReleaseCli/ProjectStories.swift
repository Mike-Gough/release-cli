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

extension Array where Element:ProjectStories {
  func asMarkdownTable() -> String {

    let rows: String = self.reduce("", {

      let stories: String = $1.stories.reduce("", {
        let thisRow = """
        * \($1)
        """
        return $0 == "" ? thisRow : $0 + "\n" + thisRow
      })

      let thisRow = """
      |\($1.project)|\($1.lastCommitId)|\($1.isDeployedToDev)|\($1.isDeployedToTest)|\($1.isDeployedToUAT)|\($1.isDeployedToProd)|\(stories)|
      """
      return $0 == "" ? thisRow : $0 + "\n" + thisRow
    })

    return """
    |application|version|In dev|In test|In uat|In prod|stories|
    |-----------|-------|------|-------|------|-------|-------|
    \(rows)
    """
  }
}



/// ||heading 1||heading 2||heading 3||
/// |cell A1|cell A2|cell A3|