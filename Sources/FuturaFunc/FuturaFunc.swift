
precedencegroup ForwardApplicationPrecedence {
    higherThan: AssignmentPrecedence
    associativity: left
}

infix operator |> : ForwardApplicationPrecedence

public func |><A, B>(a: A, f: (A)->(B)) -> B {
    return f(a)
}

precedencegroup ForwardCompositionPrecedence {
    higherThan: ForwardApplicationPrecedence
    associativity: left
}

infix operator >>> : ForwardCompositionPrecedence

public func >>><A, B, C>(f: @escaping (A)->(B), g: @escaping (B)->(C)) -> (A)->(C) {
    return { a in g(f(a)) }
}

postfix operator ^

public postfix func ^<A, B>(f: @escaping (A)->()->(B)) -> (A)->(B) {
    return { return f($0)() }
}

