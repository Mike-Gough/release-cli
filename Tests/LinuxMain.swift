import XCTest

import ReleaseCliTests

var tests = [XCTestCaseEntry]()
tests += ReleaseCliTests.allTests()
XCTMain(tests)
