import Foundation

precedencegroup ForwardApplicationPrecedence {
    higherThan: AssignmentPrecedence
    associativity: left
}

precedencegroup AsyncForwardApplicationPrecedence {
    higherThan: ForwardApplicationPrecedence
    associativity: left
}

precedencegroup FutureAlternativePrecedence {
    higherThan: AsyncForwardApplicationPrecedence
    associativity: left
}

precedencegroup ForwardCompositionPrecedence {
    higherThan: FutureAlternativePrecedence
    associativity: left
}
