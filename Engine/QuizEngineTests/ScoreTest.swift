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
    
    func test_oneCorrectAnswerOneWrong_scoresOne() {
        let score = BasicScore.score(
            for: ["correct1", "wrong"],
            comparingTo: ["correct1", "correct2"]
        )
        
        XCTAssertEqual(score, 1)
    }
    
    func test_twoCorrectAnswers_scoresTwo() {
        let score = BasicScore.score(
            for: ["correct1", "correct2"],
            comparingTo: ["correct1", "correct2"]
        )
        
        XCTAssertEqual(score, 2)
    }
    
    func test_withUnequalSizedData_twoCorrectAnswers_scoresTwo() {
        let score = BasicScore.score(
            for: ["correct1", "correct2", "an extra answer"],
            comparingTo: ["correct1", "correct2"]
        )
        
        XCTAssertEqual(score, 2)
    }
    
    private class BasicScore {
        static func score(for answers: [String], comparingTo correctAnswers: [String]) -> Int {
            var score = 0
            for (index, answer) in answers.enumerated() {
                if index >= correctAnswers.count { return score }
                score += (answer == correctAnswers[index]) ? 1 : 0
            }
            return score
        }
    }
}
