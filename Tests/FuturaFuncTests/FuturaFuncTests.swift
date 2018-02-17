import XCTest
@testable import FuturaFunc

class FuturaFuncTests: XCTestCase {
    
    func testForwardApplication() {
        let result = "TEST"
            |> String.lowercased^
        XCTAssert(result == "test")
    }
    
    func testChainedForwardApplication() {
        let result = "TEST"
            |> String.lowercased^
            |> String.uppercased^
        XCTAssert(result == "TEST")
    }
    
    func testForwardComposition() {
        let result = "TEST"
            |> String.lowercased^ >>> String.uppercased^
        XCTAssert(result == "TEST")
    }
    
    static var allTests = [
        ("testForwardApplication", testForwardApplication),
        ("testChainedForwardApplication", testChainedForwardApplication),
        ("testForwardComposition", testForwardComposition),
        ]
}
