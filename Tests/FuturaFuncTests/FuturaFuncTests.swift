import XCTest
@testable import FuturaFunc

extension String : Error {}

let testIterations: UInt = 3
let testSemaphore = DispatchSemaphore(value: 1)

extension XCTestCase {
    func asyncTest(iterationTimeout: TimeInterval = 3, iterations: UInt = testIterations, testBody: @escaping (@escaping ()->())->()) {
        
        let testQueue = DispatchQueue(label: "AsyncTestQueue")
        (0..<iterations).forEach { iteration in
            testQueue.async {
                testBody() { testSemaphore.signal() }
            }
            XCTAssert(.success == testSemaphore.wait(timeout: .now() + iterationTimeout), "Not in time - possible deadlock or fail - iteration: \(iteration)")
        }
    }
}

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
