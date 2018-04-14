public func %> <Root, Value>(_  root: Root, _ kp: KeyPath<Root, Value>) -> Value {
    return root[keyPath: kp]
}

public func <% <Root, Value>(_ kp: WritableKeyPath<Root, Value>, update: @escaping (Value) -> Value) -> (Root) -> Root {
    return { root in
        var copy = root
        copy[keyPath: kp] = update(copy[keyPath: kp])
        return copy
    }
}

public func <% <Root : AnyObject, Value>(_ kp: WritableKeyPath<Root, Value>, update: @escaping (Value) -> Value) -> (Root) -> Void {
    return { root in
        var root = root
        root[keyPath: kp] = update(root[keyPath: kp])
    }
}
