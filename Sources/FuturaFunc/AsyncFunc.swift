import FuturaAsync

infix operator |=> : AsyncForwardApplicationPrecedence

public func |=><A>(a: Future<A>, f: @escaping (A)->Void) {
    a.then(perform: f)
}
