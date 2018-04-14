public func map<A, B>(_ f: @escaping (A) -> B) -> ([A]) -> [B] {
    return { $0.map(f) }
}

public func map<A: Hashable, B, C>(_ f: @escaping (A, B) -> C) -> ([A:B]) -> [C] {
    return { $0.map(f) }
}
