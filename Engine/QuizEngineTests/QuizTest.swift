//
//  QuizTest.swift
//  QuizEngineTests
//
//  Created by Fatih Sağlam on 14.11.2023.
//

import Foundation
import XCTest
@testable import QuizEngine // TODO: Remove

final class Quiz {
    private let flow: Any
    
    private init(flow: Any) {
        self.flow = flow
    }
    
    static func start<Question: Hashable, Answer: Equatable, Delegate: QuizDelegate>(
        questions: [Question],
        delegate: Delegate,
        correctAnswers: [Question: Answer]
    ) -> Quiz where Delegate.Question == Question, Delegate.Answer == Answer {
        let flow = Flow(questions: questions, delegate: delegate, scoring: { scoring($0, correctAnswers: correctAnswers ) })
        flow.start()
        return Quiz(flow: flow)
    }

}

class QuizTest: XCTestCase {
    private let delegate = DelegateSpy()
    private var quiz: Quiz!
    
    override func setUp() {
        quiz = Quiz.start(questions: ["Q1", "Q2"], delegate: delegate, correctAnswers: ["Q1": "A1","Q2": "A2"])
    }
    
    func test_startQuiz_answerZeroOutOfTwoCorrect_scoresZero() {
        delegate.answerCallback("wrong")
        delegate.answerCallback("wrong")
        
        XCTAssertEqual(delegate.handledResult!.score, 0)
    }
    
    func test_startQuiz_answerOneOutOfTwoCorrect_scoresOne() {
        delegate.answerCallback("A1")
        delegate.answerCallback("wrong")
        
        XCTAssertEqual(delegate.handledResult!.score, 1)
    }
    
    func test_startQuiz_answerTwoOutOfTwoCorrect_scoresTwo() {
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        
        XCTAssertEqual(delegate.handledResult!.score, 2)
    }
    
    private class DelegateSpy: Router, QuizDelegate {
        var handledResult: Result<String, String>? = nil
        var answerCallback: ((String) -> Void) = { _ in }
        
        func handle(question: String, answerCallback: @escaping (String) -> Void) {
            self.answerCallback = answerCallback
        }
        
        func routeTo(question: String, answerCallback: @escaping (Answer) -> Void) {
            self.handle(question: question, answerCallback: answerCallback)
        }
        
        func handle(result: Result<String, String>) {
            handledResult = result
        }
        
        func routeTo(result: Result<String, String>) {
            self.handle(result: result)
        }
    }
}
