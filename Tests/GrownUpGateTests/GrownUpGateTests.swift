import XCTest
import SwiftUI
@testable import GrownUpGate

@available(iOS 15.0, *)
final class GrownUpGateTests: XCTestCase {
    func testParentGateChallenge() throws {
        let challenge = ParentGateChallenge.randomMathChallenge()
        XCTAssertEqual(challenge.question, "What is 7 + 3?")
        XCTAssertEqual(challenge.answer, "10")
    }
    
    func testParentGateView() throws {
        let isPresented = Binding.constant(true)
        let view = ParentGate(
            isPresented: isPresented,
            challenge: "Test Challenge",
            correctAnswer: "Test Answer",
            onSuccess: {}
        )
        XCTAssertNotNil(view)
    }
} 
