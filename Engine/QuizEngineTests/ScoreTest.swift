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
        XCTAssertEqual(BasicScore.score(for: ["not a match"], comparingTo: ["an answer"]), 0)
    }
    
    func test_oneCorrectAnswer_scoresOne() {
        XCTAssertEqual(BasicScore.score(for: ["an answer"], comparingTo: ["an answer"]), 1)
    }
    
    func test_oneCorrectAnswerOneWrong_scoresOne() {
        let score = BasicScore.score(
            for: ["an answer", "not a match"],
            comparingTo: ["an answer", "another answer"]
        )
        
        XCTAssertEqual(score, 1)
    }
    
    func test_twoCorrectAnswers_scoresTwo() {
        let score = BasicScore.score(
            for: ["an answer", "another answer"],
            comparingTo: ["an answer", "another answer"]
        )
        
        XCTAssertEqual(score, 2)
    }
    
    func test_withTooManyAnswers_twoMatchingAnswers_scoresTwo() {
        let score = BasicScore.score(
            for: ["an answer", "another answer", "an extra answer"],
            comparingTo: ["an answer", "another answer"]
        )
        
        XCTAssertEqual(score, 2)
    }
    
    func test_withTooManyCorrectAnswers_oneMatchingAnswers_scoresOne() {
        let score = BasicScore.score(
            for: ["not matching", "another answer"],
            comparingTo: ["an answer", "another answer", "an extra answer"]
        )
        
        XCTAssertEqual(score, 1)
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
