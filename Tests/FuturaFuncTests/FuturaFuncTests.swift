import XCTest
@testable import FuturaFunc

extension String : Error {}

class FuturaFuncTests: XCTestCase {
    
    func testForwardApplication() {
        let result = "TEST"
            |> String.lowercased^
        XCTAssert(result == "test")
    }

    func testBackwardApplication() {
        let result =
                String.lowercased^
                        <| "TEST"
        XCTAssert(result == "test")
    }
    
    func testChainedForwardApplication() {
        let result = "TEST"
            |> String.lowercased^
            |> String.uppercased^
        XCTAssert(result == "TEST")
    }

    func testChainedBackwardApplication() {
        let result =
                String.uppercased^
                <| String.lowercased^
                <| "TEST"
        XCTAssert(result == "TEST")
    }
    
    func testMixedApplication() {
        let result =
            String.uppercased^
                <| String.lowercased^
                <| "TEST"
        XCTAssert(result == "TEST")
    }
    
    func testForwardComposition() {
        let result = "TEST"
            |> String.lowercased^
                >>> String.uppercased^
        XCTAssert(result == "TEST")
    }

    func testBackwardComposition() {
        let result = "TEST"
                |> String.uppercased^
                <<< String.lowercased^
        XCTAssert(result == "TEST")
    }
    
    func testMixedComposition() {
        let result =
            "TEST"
                |> { $0 + "A" }
                >>> { $0 + "B" }
                <<< { $0 + "C" }
        print(result)
        XCTAssert(result == "TESTACB")
    }
    
    func testLens() {
        let x = A(b: A.B(c: A.B.C(str: "TEST")))
        let y = x |> \A.b.c.str <% { $0 + "ED!" }
        let ystr = y %> \A.b.c.str |> String.lowercased^
        XCTAssert(ystr == "tested!")
    }
    
    static var allTests = [
        ("testForwardApplication", testForwardApplication),
        ("testBackwardApplication", testBackwardApplication),
        ("testChainedForwardApplication", testChainedForwardApplication),
        ("testChainedBackwardApplication", testChainedBackwardApplication),
        ("testMixedApplication", testMixedApplication),
        ("testForwardComposition", testForwardComposition),
        ("testBackwardComposition", testBackwardComposition),
        ("testMixedComposition", testMixedComposition),
        ("testLens", testLens),
        ]
}

struct A {
    struct B {
        struct C {
            var str: String
        }
        var c: C
    }
    var b: B
}
