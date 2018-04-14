import FuturaFunc

var str = "Hello, playground"


enum XEnum {
    case one
    case two
}

struct XStruct {
    var enu: XEnum
    var num: Int
}

struct TestStruct {
    var str: String
    var xst: XStruct
}

class TestClass {
    var str: String = ""
    var xst: XStruct = XStruct(enu: .one, num: 2)
}


let testStr = TestStruct(str: "TEST", xst: XStruct(enu: .one, num: 2))
let testCls = TestClass()

func icr(x: Int) -> Int {
    return x + 1
}

\TestStruct.xst.enu <% { _ in .two }

let val =
    testStr
        |> \TestStruct.str
        <% { _ in
        "TEST"
        |> { $0 + "!" }
        >>> { $0 + " small" }
        |> { $0 + " better" }
        <<< String.uppercased^
}


testStr
    |> \TestStruct.str
    <% String.uppercased^

struct A {
    struct B {
        struct C {
            var str: String
        }
        var c: C
    }
    var b: B
}

let a = A(b: A.B(c: A.B.C(str: "TEST")))
let d = a |> \A.b.c.str <% { $0 + "ED!" }
let dstr = d %> \A.b.c.str |> String.lowercased^
