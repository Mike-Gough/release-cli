import XCTest
@testable import release_cli

final class release_cliTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(release_cli().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
