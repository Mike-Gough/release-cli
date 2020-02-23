import XCTest
@testable import ReleaseCli

final class StringTests: XCTestCase {

    func getStoryNumbers() {

        let commits: String = """
        ABC-001-apple
        ABC-002 bannanna
        ABC-003/ABC-004 carrot
        """

        XCTAssertEqual(commits.storyNumbers(), ["ABC-001"])
    }

    static var allTests = [
        ("storyNumbers", getStoryNumbers),
    ]
}
