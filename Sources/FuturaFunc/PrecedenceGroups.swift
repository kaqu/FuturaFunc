precedencegroup ForwardApplicationPrecedence {
    higherThan: AssignmentPrecedence
    associativity: left
}

precedencegroup LensGetterPrecedence {
    higherThan: ForwardApplicationPrecedence
    associativity: left
}

precedencegroup LensSetterPrecedence {
    higherThan: LensGetterPrecedence
    associativity: left
}

precedencegroup ForwardCompositionPrecedence {
    higherThan: LensSetterPrecedence
    associativity: left
}

precedencegroup ForwardTypeCompositionPrecedence {
    higherThan: ForwardCompositionPrecedence
    associativity: left
}

precedencegroup BackwardApplicationPrecedence {
    higherThan: ForwardTypeCompositionPrecedence
    associativity: right
}

precedencegroup BackwardCompositionPrecedence {
    higherThan: BackwardApplicationPrecedence
    associativity: right
}


