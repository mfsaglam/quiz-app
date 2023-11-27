//
//  BasicScore.swift
//  QuizApp
//
//  Created by Fatih Sağlam on 27.11.2023.
//

import Foundation

final class BasicScore {
    static func score(for answers: [String], comparingTo correctAnswers: [String]) -> Int {
        zip(answers, correctAnswers).reduce(0) { score, tuple in
            return score + (tuple.0 == tuple.1 ? 1 : 0)
        }
    }
}
