import XCTest
import FuturaAsync
@testable import FuturaFunc

class AsyncFuncTests: XCTestCase {
    
    func testSyncApplicationSuccess() {
        asyncTest { complete in
            let promise = Promise<String>()
            DispatchQueue.global().async {
                sleep(1)
                try? promise.fulfill(with: "TEST")
            }
            let future = promise.future
            do {
                let value: String = try future |-> String.lowercased^
                XCTAssert(value == "test", "Future value not matching: expected-test, provided-\(value)")
            } catch {
                XCTFail("Future failed with error - \(error)")
            }
            complete()
        }
    }
    
    func testSyncApplicationFailure() {
        asyncTest { complete in
            let promise = Promise<String>()
            DispatchQueue.global().async {
                sleep(1)
                try? promise.fail(with: "TEST")
            }
            let future = promise.future
            do {
                _ = try future |-> String.lowercased^
                XCTFail("Future not failed")
            } catch {
                XCTAssert(error as? String == "TEST", "Future error not matching: expected-TEST, provided-\(error)")
            }
            complete()
        }
    }
    
    func testAsyncApplicationSuccess() {
        asyncTest { complete in
            let promise = Promise<String>()
            DispatchQueue.global().async {
                sleep(1)
                try? promise.fulfill(with: "TEST")
            }
            let future = promise.future
            let catchable =
                future
                    |=> String.lowercased^
                    >>> { (val: String) -> Void in
                            XCTAssert(val == "test", "Future value not matching: expected-\(Void()), provided-\(val)")
                        }
                    >>> complete
            catchable.catch { error in
                XCTFail("Future failed with error - \(error)")
                complete()
            }
        }
    }
    
    func testAsyncApplicationFailure() {
        asyncTest { complete in
            let promise = Promise<String>()
            DispatchQueue.global().async {
                sleep(1)
                try? promise.fail(with: "TEST")
            }
            let future = promise.future
            let catchable =
                future
                    |=> String.lowercased^
                    >>> { (_) -> Void in
                        XCTFail("Future not failed")
                    }
                    >>> complete
            catchable.catch { error in
                XCTAssert(error as? String == "TEST", "Future error not matching: expected-TEST, provided-\(error)")
                complete()
            }
        }
    }
    
    func testSyncResultAlternativeSuccess() {
        asyncTest { complete in
            let promise = Promise<String>()
            DispatchQueue.global().async {
                sleep(1)
                try? promise.fail(with: "TEST")
            }
            let future = promise.future
            async {
                try future
                    |->
                    String.lowercased^ >>> { _ in XCTFail("Future not failed") }
                    <||>
                    { XCTAssert($0 as? String == "TEST", "Future error not matching: expected-\(Void()), provided-\($0)") }
                complete()
            }
            .catch { error in
                XCTFail("Future failed with error - \(error)")
                complete()
            }
        }
    }
    
    func testSyncResultAlternativeFailure() {
        asyncTest { complete in
            let promise = Promise<String>()
            DispatchQueue.global().async {
                sleep(1)
                try? promise.fulfill(with: "TEST")
            }
            let future = promise.future
            async {
                try future
                    |->
                    String.lowercased^ >>> { XCTAssert($0 == "test", "Future value not matching: expected-\(Void()), provided-\($0)") }
                    <||>
                    { XCTFail("Future failed with error - \($0)") }
                complete()
                }
                .catch { error in
                    XCTFail("Future failed with error - \(error)")
                    complete()
            }
        }
    }
    
    static var allTests = [
        ("testSyncApplicationSuccess", testSyncApplicationSuccess),
        ("testSyncApplicationFailure", testSyncApplicationFailure),
        ("testAsyncApplicationSuccess", testAsyncApplicationSuccess),
        ("testAsyncApplicationFailure", testAsyncApplicationFailure),
        ("testSyncResultAlternativeSuccess", testSyncResultAlternativeSuccess),
        ("testSyncResultAlternativeFailure", testSyncResultAlternativeFailure),
        ]
}
