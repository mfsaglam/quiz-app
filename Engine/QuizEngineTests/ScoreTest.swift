//
//  ScoreTest.swift
//  QuizEngineTests
//
//  Created by Fatih Sağlam on 24.11.2023.
//

import XCTest

class ScoreTest: XCTestCase {
    func test_noAnswers_scoresZero() {
        let score = BasicScore.score(for: [])
        XCTAssertEqual(score, 0)
    }
    
    private class BasicScore {
        static func score(for: [Any]) -> Int {
            return 0
        }
    }
}
