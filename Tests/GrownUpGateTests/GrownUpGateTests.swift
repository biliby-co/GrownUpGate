import XCTest
import SwiftUI
@testable import GrownUpGate

@available(iOS 15.0, *)
final class GrownUpGateTests: XCTestCase {
    func testParentGateChallenge() throws {
        let challenge = ParentGateChallenge.mathChallenge
        XCTAssertEqual(challenge.question, "What is 7 + 3?")
        XCTAssertEqual(challenge.answer, "10")
    }
    
    func testRandomChallenge() throws {
        let challenge = ParentGateChallenge.randomChallenge()
        XCTAssertFalse(challenge.question.isEmpty)
        XCTAssertFalse(challenge.answer.isEmpty)
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