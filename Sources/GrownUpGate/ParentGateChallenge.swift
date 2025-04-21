import Foundation

public struct ParentGateChallenge {
    public let firstNumber: Int
    public let secondNumber: Int
    
    public var question: String {
        "\(firstNumber) + \(secondNumber) = ?"
    }
    
    public var answer: String {
        String(firstNumber + secondNumber)
    }
    
    public static func randomMathChallenge() -> ParentGateChallenge {
        let firstNumber = Int.random(in: 20...90)
        let secondNumber = Int.random(in: 2...9)
        return ParentGateChallenge(firstNumber: firstNumber, secondNumber: secondNumber)
    }
} 
