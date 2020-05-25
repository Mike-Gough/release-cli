import Foundation

extension Array where Element: Hashable {
    func element(after index: Index) -> Element? {
        let nextIndex = self.index(after: index)
        return self.element(at: nextIndex)
    }
    private func element(at index: Index) -> Element? {
        guard index >= self.startIndex else { return nil }
        guard index < self.endIndex else { return nil }
        return self[index]
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
      |\($1.project)|\($1.lastCommitId)|\($1.devCommitId)|\($1.isDeployedToDev)|\($1.testCommitId)|\($1.isDeployedToTest)|\($1.uatCommitId)|\($1.isDeployedToUAT)|\($1.prodCommitId)|\($1.isDeployedToProd)|\(stories)|
      """
      return $0 == "" ? thisRow : $0 + "\n" + thisRow
    })

    return """
    |application|version|dev id|In dev|test id|In test|uat id|In uat|prod id|In prod|stories|
    |-----------|-------|------|------|-------|-------|------|------|-------|-------|-------|
    \(rows)
    """
  }
}

extension Array where Element: Hashable {
    func unique() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.unique()
    }
}