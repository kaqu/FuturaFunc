import XCTest
import FuturaAsync
@testable import FuturaFunc

class AsyncFuncTests: XCTestCase {
    
    func testAsyncApplication() {
        asyncTest { complete in
            let promise = Delayed<String>()
            DispatchQueue.global().async {
                sleep(1)
                promise.become("TEST")
            }
            let future = promise.future
                future
                    |=> String.lowercased^
                    >>> { (val: String) -> Void in
                            XCTAssert(val == "test", "Future value not matching: expected-\(Void()), provided-\(val)")
                        }
                    >>> { _ in complete() }
        }
    }
    
    static var allTests = [
        ("testAsyncApplication", testAsyncApplication),
        ]
}
