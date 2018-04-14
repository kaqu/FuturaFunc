postfix operator ^

public postfix func ^<A, B>(f: @escaping (A)->()->(B)) -> (A)->(B) {
    return zurry(flip(f))
}
