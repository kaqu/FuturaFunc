public func filter<A>(_ p: @escaping (A) -> Bool) -> ([A]) -> [A] {
    return { $0.filter(p) }
}

public func filter<A: Hashable, B>(_ p: @escaping (A, B) -> Bool) -> ([A:B]) -> [A:B] {
    return { $0.filter(p) }
}
