//
//  QuizTest.swift
//  QuizEngineTests
//
//  Created by Fatih Sağlam on 14.11.2023.
//

import Foundation
import XCTest
import QuizEngine

class QuizTest: XCTestCase {
    private var quiz: Quiz!
    
    func test_startQuiz_answerOneOutOfTwoCorrect_scoresOne() {
        let delegate = DelegateSpy()
        quiz = Quiz.start(questions: ["Q1", "Q2"], delegate: delegate, correctAnswers: ["Q1": "A1","Q2": "A2"])
        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")
        
        XCTAssertEqual(delegate.completedQuizzes.count, 1)
        assertEqual(delegate.completedQuizzes[0], [("Q1", "A1"), ("Q2", "A2")])
    }
    
    // TODO: Remove duplication
    /// `assertEqual`
    /// `DelegateSpy`
    private func assertEqual(
        _ a1: [(String, String)],
        _ a2: [(String, String)],
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertTrue(
            a1.elementsEqual(a2, by: ==),
            "\(a1) is not equal to \(a2)",
            file: file,
            line: line
        )
    }
    
    private class DelegateSpy: QuizDelegate {
        
        var handledResult: Result<String, String>? = nil
        var completedQuizzes: [[(String, String)]] = []
        var answerCompletion: ((String) -> Void) = { _ in }
        
        func answer(for: String, completion: @escaping (String) -> Void) {
            self.answerCompletion = completion
        }
        
        func didCompleteQuiz(withAnswers answers: [(question: String, answer: String)]) {
            completedQuizzes.append(answers)
        }
        
        func handle(result: Result<String, String>) {
            handledResult = result
        }
    }
}
