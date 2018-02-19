import Foundation

precedencegroup ForwardApplicationPrecedence {
    higherThan: AssignmentPrecedence//AsyncForwardApplicationPrecedence
    associativity: left
}

precedencegroup SyncForwardApplicationPrecedence {
    higherThan: ForwardApplicationPrecedence
    associativity: left
}

precedencegroup AsyncForwardApplicationPrecedence {
    higherThan: SyncForwardApplicationPrecedence//ForwardCompositionPrecedence
    associativity: left
}

precedencegroup FutureAlternativePrecedence {
    higherThan: AsyncForwardApplicationPrecedence//SyncForwardApplicationPrecedence
    associativity: left
}

precedencegroup ForwardCompositionPrecedence {
    higherThan: FutureAlternativePrecedence
    associativity: left
}
