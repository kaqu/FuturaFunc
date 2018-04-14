public func |><A, B>(a: A, f: (A) -> B) -> B {
    return f(a)
}

public func |> <A>(a: inout A, f: (inout A) -> Void) -> Void {
    return f(&a)
}

public func <| <A, B>(f: (A) -> B, a: A) -> B {
    return f(a)
}

public func <| <A>(f: (inout A) -> Void, a: inout A) -> Void {
    return f(&a)
}
