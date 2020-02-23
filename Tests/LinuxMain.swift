import XCTest

import release_cliTests

var tests = [XCTestCaseEntry]()
tests += release_cliTests.allTests()
XCTMain(tests)
