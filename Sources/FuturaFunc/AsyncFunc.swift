import FuturaAsync

infix operator |-> : SyncForwardApplicationPrecedence

public func |-><A, B>(a: Future<A>, f: (A)->(B)) throws -> B {
    return try f(a.await())
}

public func |-><A, B>(a: Future<A>, f: (Future<A>.Result)->(B)) throws -> B {
    return try f(a.resultAwait())
}

infix operator <||> : FutureAlternativePrecedence

public func <||><A,B>(f: @escaping (A)->(B), g: @escaping (Error)->(B))->(Future<A>.Result)->(B) {
    return { a in
        switch a {
        case let .value(value):
            return f(value)
        case let .error(error):
            return g(error)
        }
    }
}

infix operator |=> : AsyncForwardApplicationPrecedence

public func |=><A, B>(a: Future<A>, f: @escaping @autoclosure ()->((A)->B)) -> Catchable {
    return async { try f()(a.await()) }
}
