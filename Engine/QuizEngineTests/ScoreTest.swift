//
//  ScoreTest.swift
//  QuizEngineTests
//
//  Created by Fatih Sağlam on 24.11.2023.
//

import XCTest

class ScoreTest: XCTestCase {
    func test_noAnswers_scoresZero() {
        let score = BasicScore.score(for: [], comparingTo: [])
        XCTAssertEqual(score, 0)
    }
    
    func test_oneWrongAnswer_scoresZero() {
        XCTAssertEqual(BasicScore.score(for: ["wrong"], comparingTo: ["correct"]), 0)
    }
    
    func test_oneCorrectAnswer_scoresOne() {
        XCTAssertEqual(BasicScore.score(for: ["correct"], comparingTo: ["correct"]), 1)
    }
    
    private class BasicScore {
        static func score(for answers: [String], comparingTo correctAnswers: [String]) -> Int {
            if answers.isEmpty { return 0 }
            return answers == correctAnswers ? 1 : 0
        }
    }
}
